
#include <iostream>
#include "DataFileReader.h"
/*
class DataFileReader
{
    protected:
        std::string filename;
        std::string delimeter;

    public:
*/
DataFileReader::DataFileReader(std::string filename, std::string delimeter)// : obj(filename, delimeter)
{
    filename = filename;
    delimeter = filename;
    std::cout << "creating object DataFileReader" << std::endl;
}
//};

