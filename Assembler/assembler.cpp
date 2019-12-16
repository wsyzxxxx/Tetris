// Author: Susie
// You need to pay 1 yuan for translating one file
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#include <iostream>
#include <cstdlib>
#include <string>
#include <fstream>
#include <sstream>
#include <exception>
#include <unordered_map>
#include <ctype.h>
#include <iomanip>

int counter;
std::unordered_map<std::string, int> label_map;

void printHeaders(std::ostream & oss) {
    oss << "DEPTH = 4096;" << std::endl;
    oss << "WIDTH = 32;" << std::endl;
    oss << "ADDRESS_RADIX = DEC;" << std::endl;
    oss << "DATA_RADIX = BIN;" << std::endl;
    oss << "CONTENT" << std::endl;
    oss << "BEGIN" << std::endl;
}

void printFooters(std::ostream & oss) {
    oss << "[" << std::setfill('0') << std::setw(4) << counter << ".." << "4095]"
        << " : "
        << "00000000000000000000000000000000;" << std::endl;
    oss << "END;" << std::endl;
}

int findNextRegister(std::string line, size_t & foundSpace) {
    size_t foundDollar = line.find("$");
    foundSpace = line.find(" ", foundDollar);
    if (foundDollar == std::string::npos || foundSpace < foundDollar) {
        return -1;
    }

    std::string rdString;
    if (foundSpace == std::string::npos) {
        rdString = line.substr(foundDollar+1);
    } else {
        rdString = line.substr(foundDollar+1, foundSpace - foundDollar);
    }
    if (rdString == "rstatus") {
        return 30;
    } else if (rdString == "ra") {
        return 31;
    } else {
        return std::stoi(rdString);
    }
}

int findNextImmed(std::string line, size_t & foundSpace) {
    int res = 0;
    int flag = 1;
    for (size_t i = 0; i < line.size(); i++) {
        if (line[i] == '-')
            flag = -1;
        if (line[i] >= '0' && line[i] <= '9') {
            res = res * 10 + line[i++] - '0';
            while (line[i] >= '0' && line[i] <= '9' && i < line.size()) {
                res = res * 10 + line[i++] - '0';
            }
            foundSpace = i;
            return res * flag;
        }
    }
    return res * flag;
}

std::string findNextLabel(std::string line, size_t & foundSpace) {
    std::string res;
    for (size_t i = 0; i < line.size(); i++) {
        if (line[i] == '#') break;
        if (isalpha(line[i])) res += line[i];
        if (res.size()!= 0 && (line[i] >= '0' && line[i] <= '9')) res += line[i];
        if (line[i] == '_') res += line[i];
    }
    return res;
}

void printBinary(std::ostream & oss, int num, int limit) {
    int count = 0;
    bool array[128] = {0};
    while (num && count < 16) {
        array[count++] = num & 1;
        num = num >> 1;
    }

    array[16] = num < 0 ? 1 : 0;

    if (count > limit) {
        oss << std::setfill('0') << std::setw(4)
            << counter++ << " : " "THIS LINE HAS SYNTAX ERROR!!!!!!!!!" << std::endl << std::endl;
    } else {
        for (int i = limit-1; i >= 0; i--) {
            oss << array[i];
        }
    }
}

void parseRType(std::string op, std::string opcode, std::string line, std::ostream & oss, std::string oriLine) {
    try {
        int rd, rs, rt;
        size_t foundSpace;

        //rd
        rd = findNextRegister(line, foundSpace);
        line = line.substr(foundSpace+1);
        //rs
        rs = findNextRegister(line, foundSpace);
        line = line.substr(foundSpace+1);
        //rt
        rt = findNextRegister(line, foundSpace);

        oss << std::setfill('0') << std::setw(4)
            << counter++ << " : "
            << opcode;
        printBinary(oss, rd, 5);
        printBinary(oss, rs, 5);
        printBinary(oss, rt, 5);
        oss << "0000" << "0000" << "0000" << ";";
        oss << " -- " << oriLine;

        oss << std::endl << std::endl;
        
    } catch (std::exception const & e) {
        std::cout << "error R : " << e.what() << " at: " << counter << std::endl;
    }
}

void parseIType(std::string op, std::string opcode, std::string line, std::ostream &oss, std::string oriLine)
{
    try
    {
        int rd, rs, immed;
        size_t foundSpace;

        //rd
        rd = findNextRegister(line, foundSpace);
        line = line.substr(foundSpace + 1);
        //rs
        rs = findNextRegister(line, foundSpace);
        line = line.substr(foundSpace + 1);
        

        oss << std::setfill('0') << std::setw(4)
            << counter++ << " : "
            << opcode;
        printBinary(oss, rd, 5);
        printBinary(oss, rs, 5);

        std::string temp_label = findNextLabel(line, foundSpace);
        if (temp_label.size() == 0) {
            immed = findNextImmed(line, foundSpace);
            printBinary(oss, immed, 17);
        } else {
            std::unordered_map<std::string, int>::const_iterator got = label_map.find(temp_label);
            if (got == label_map.end()) {
                std::cout << "error IT: not in map" << std::endl << "at: " << counter-1 << std::endl;
                std::cout << "label: ***" << temp_label << "***" << std::endl;
            } else {
                int temp = got->second - counter;
                printBinary(oss, temp, 17);
            }
        }

        oss << "; -- " << oriLine;
 
        oss << std::endl << std::endl;
    }
    catch (std::exception const &e)
    {
        std::cout << "error I : " << e.what() << " at: " << counter << std::endl;
    }
}

void parseJType(std::string op, std::string opcode, std::string line, std::ostream &oss, std::string oriLine)
{

    int immed;
    size_t foundSpace;
    oss << std::setfill('0') << std::setw(4)
        << counter++ << " : "
        << opcode;


    std::string temp_label = findNextLabel(line, foundSpace);
    if (temp_label.size() == 0) {
        immed = findNextImmed(line, foundSpace);
        printBinary(oss, immed, 27);
    } else {
        std::unordered_map<std::string, int>::const_iterator got = label_map.find(temp_label);
        if (got == label_map.end()) {
            std::cout << "error JT: not in map" << std::endl << "at: " << counter-1 << std::endl;
            std::cout << temp_label << std::endl;
        } else {
            printBinary(oss, got->second, 27);
        }
    }
    oss << "; -- " << oriLine;
    oss << std::endl << std::endl;
}

void parseI2Type(std::string op, std::string opcode, std::string line, std::ostream &oss, std::string oriLine)
{
    try
    {
        int rd;
        size_t foundSpace;

        //rd
        rd = findNextRegister(line, foundSpace);

        oss << std::setfill('0') << std::setw(4)
            << counter++ << " : "
            << opcode;
        printBinary(oss, rd, 5);
        oss << "00000" << "0000" << "0000" << "0000" << "0000" << "0";
        oss << "; -- " << oriLine;
        oss << std::endl << std::endl;
    }
    catch (std::exception const &e)
    {
        std::cout << "error I2 : " << e.what() << " at: " << counter  << std::endl;
    }
}

void parseI3Type(std::string op, std::string opcode, std::string line, std::ostream &oss, std::string oriLine)
{
    try
    {
        int rd, immed, rs;
        size_t foundSpace;

        //rd
        rd = findNextRegister(line, foundSpace);
        line = line.substr(foundSpace + 1);
        //immed
        immed = findNextImmed(line, foundSpace);
        line = line.substr(foundSpace);
        //rt
        if (line.substr(0, 1) == "(") {
            foundSpace = line.find(")");
            if (foundSpace != std::string::npos) {
                line[foundSpace] = ' ';
                rs = findNextRegister(line, foundSpace);
            } else {
                throw std::exception();
            }
        } else {
            throw std::exception();
        }



        oss << std::setfill('0') << std::setw(4)
            << counter++ << " : "
            << opcode;
        printBinary(oss, rd, 5);
        printBinary(oss, rs, 5);
        printBinary(oss, immed, 17);
        oss << "; -- " << oriLine << std::endl << std::endl;
    }
    catch (std::exception const &e)
    {
        std::cout << "error I3 : " << e.what() << " at: " << counter << std::endl;
    }
}
void getAllLabel(std::string line) {
    size_t found_colon = line.find(':');
    if (found_colon != std::string::npos) {
        std::string label = line.substr(0, found_colon);
        label_map.insert(std::pair<std::string, int>(label, counter));
    }
    counter++;
}
void parseOneLine(std::ostream & oss, std::string line) {
    size_t found_colon = line.find(':');
    if (found_colon != std::string::npos) {
        std::string label = line.substr(0, found_colon);
        //label_map.insert(std::pair<std::string, int>(label, counter));
    }
    if (line[found_colon + 1] == ' ') {
        line = line.substr(found_colon + 2);
    } else {
        line = line.substr(found_colon + 1);
    }
    size_t found = line.find(' ');
    if (found == std::string::npos) {
        if (line == "nop") {
            oss << std::setfill('0') << std::setw(4)
            << counter++ << " : "
            << "00000000" << "00000000" << "00000000" << "00000000"
            << "; -- " << line << std::endl << std::endl;
            return;
        }
        oss << std::setfill('0') << std::setw(4)
            << counter++ << " : " << "THIS LINE HAS SYNTAX ERROR!!!!!!!!!" << std::endl << std::endl;
        return;
    }

    std::string op = line.substr(0, found);
    if (op == "add")
        parseRType("add", "00000", line.substr(found + 1), oss, line);
    else if (op == "sub")
        parseRType("sub", "00001", line.substr(found + 1), oss, line);
    else if (op =="and")
        parseRType("and", "00010", line.substr(found + 1), oss, line);
    else if (op == "or")
        parseRType("or", "00011", line.substr(found + 1), oss, line);
    else if (op == "sll")
        parseRType("sll", "00100", line.substr(found + 1), oss, line);
    else if (op == "srl")
        parseRType("srl", "00101", line.substr(found + 1), oss, line);
    else if (op == "addi")
        parseIType("addi", "00110", line.substr(found + 1), oss, line);
    else if (op == "lw")
        parseI3Type("lw", "00111", line.substr(found + 1), oss, line);
    else if (op == "sw")
        parseI3Type("sw", "01000", line.substr(found + 1), oss, line);
    else if (op == "beq")
        parseIType("beq", "01001", line.substr(found + 1), oss, line);
    else if (op == "bgt")
        parseIType("bgt", "01010", line.substr(found + 1), oss, line);
    else if (op == "jr")
        parseI2Type("jr", "01011", line.substr(found + 1), oss, line);
    else if (op == "j")
        parseJType("j", "01100", line.substr(found + 1), oss, line);
    else if (op == "jal")
        parseJType("jal", "01101", line.substr(found + 1), oss, line);
    else if (op == "input")
        parseI2Type("input", "01110", line.substr(found + 1), oss, line);
    else if (op == "output")
        parseI2Type("output", "01111", line.substr(found + 1), oss, line);
    else if (op == "nop")
        oss << std::setfill('0') << std::setw(4)
            << counter++ << " : "
            << "00000000" << "00000000" << "00000000" << "00000000"
            << "; -- " << line << std::endl << std::endl;
    else {
        oss << std::setfill('0') << std::setw(4)
            << counter++ << " : " << "THIS LINE HAS SYNTAX ERROR!!!!!!!!!" << std::endl << std::endl;
        return;
    }
}

int main(int argc, char ** argv) {
    if (argc != 3) {
        std::cerr << "USAGE: ./assembler inputFile outputFile" << std::endl;
        return EXIT_FAILURE;
    }

    std::ifstream ifs(argv[1]);
    std::string line_0;
    if (ifs.fail()) {
        ifs.close();
        std::cerr << "Open Failed!!!" << std::endl;
        return EXIT_FAILURE;
    }
    while (std::getline(ifs, line_0)) {
        if (!line_0.empty()) {
            for (size_t i = 0; i < line_0.size(); ++i) {
                if (line_0[i] != ' ' && line_0[i] != '\t') {
                    getAllLabel(line_0);
                    break;
                }
            }
        }
    }
    ifs.close();

    //find every label
    counter = 0;
    ifs.open(argv[1]);
    std::ofstream ofs(argv[2]);

    if (ifs.fail() || ofs.fail()) {
        ifs.close();
        ofs.close();
        std::cerr << "ERROR: open input file or output file error!!!" << std::endl;
        return EXIT_FAILURE;
    }

    printHeaders(ofs);
    std::string line;
    while (std::getline(ifs, line)) {
        if (!line.empty()) {
            for (size_t i = 0; i < line.size(); ++i) {
                if (line[i] != ' ' && line[i] != '\t') {
                    parseOneLine(ofs, line);
                    break;
                }
            }
        }
    }
    printFooters(ofs);

    ifs.close();
    ofs.close();
    //std::unordered_map::iterator it = label_map.begin(); 
    for(auto a : label_map) {
        std::cout << "[label]: " << a.first <<"     "
        << "[counter]: " << a.second << std::endl;
    }
    return EXIT_SUCCESS;
}
