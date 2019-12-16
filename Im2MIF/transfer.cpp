#include <iostream>
#include <sstream>
#include <fstream>
#include <string>

int main(int argc, char ** argv) {
	for (size_t i = 1; i < argc; i++) {
		std::string line;
		std::ifstream ifs(argv[i]);
		std::ofstream ofs(std::string(argv[i]) + ".txt");

		int a;

		ofs << "'{";

		for (size_t i = 0; i < 6; i++) {
			getline(ifs, line);
			//ofs << line << std::endl;
		}
		for (size_t i = 0; i < 20000; i++) {
			getline(ifs, line);
			size_t found = line.find(":");
			std::istringstream iss(line.substr(found+2));
			iss >> std::hex >> a;
			a += 97;
			if (i != 19999)
				ofs << "8'h" << std::hex << a << ", ";
			else
			 	ofs << "8'h" << std::hex << a;
		}

		ofs << "};";
		ifs.close();
		ofs.close();
	}


}
