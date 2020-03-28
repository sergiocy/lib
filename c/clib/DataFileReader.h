#ifndef DATAFILEREADER_H
#define DATAFILEREADER_H

#include <iostream>
#include <fstream>
#include <vector>



class DataFileReader
{
    protected:
        std::string filename;
        std::string delimeter;
        bool has_header;
        std::vector<std::string> str_rows;

        //std::string str_header;
        int n_col;

    public:
        DataFileReader(std::string filename, std::string delimeter, bool has_header, std::string str_header);
        std::string get_filename();

    private:
        std::vector<std::string> set_header();
        std::vector<std::string> set_datarows_from_csv();
};


// ##################################################
//constructor
DataFileReader::DataFileReader(std::string filename, std::string delimeter, bool has_header=true, std::string str_header="")// : obj(filename, delimeter)
{
    this->filename = filename;
    this->delimeter = delimeter;
    this->has_header = has_header;
    //this->str_header = str_header;

    //get and validate input header
    set_header(delimeter, has_header, str_header);

    //get and validate datarows as strings
    this->str_rows = set_datarows_from_csv();
    std::cout << this->str_rows[0] << std::endl;

}


// ##################################################
//getters & setters
std::string DataFileReader::get_filename()
{
    return filename;
}


// ##################################################
//methods
std::vector<std::string> DataFileReader::set_datarows_from_csv()
{
    std::ifstream datafile_instream;
    std::string line;
    std::vector<std::string> rows;

    datafile_instream.open(filename, std::ios::in);
    if (datafile_instream.is_open())
    {
        while(!datafile_instream.eof())
        {
            getline(datafile_instream, line);
            rows.push_back(line);
        }

        datafile_instream.close();
    }

    return rows;
}


std::vector<std::string> DataFileReader::set_header(delimeter, has_header, str_header)
{
    std::cout << this->has_header << std::endl;
    std::cout << this->str_header << std::endl;

    if(!has_header & str_header != "")
    {

    }
}

#endif

