#include <iostream>
#include <unistd.h>

#include "lib/DataFileReader.h"
//extern void DataFileReader()
//using namespace std;



// constants defined to dev...
#define FILENAME "C:/sc-sync/projects/data/input/clusters/test/data_clustering_test.csv"
//#define FILENAME "../../../data/input/clusters/test/data_clustering_test.csv"
#define DELIM ","
#define HEADER false
#define HEADER_NAMES "cd_f_n,cd_a_p,dt,id_f,l_90,r_90,l_60,r_60,l_40,r_40,l_30,r_30,l_20,r_20,l_13,r_13,l_6,r_6,l_3,r_3,l_0,r_0"



int main()
{
    //std::string FILENAME = "C:/sc-sync/projects/data/input/clusters/test/data_clustering_test.csv";
    std::cout << "reading data from: " << FILENAME << std::endl;

    //std::string DELIM = ",";
    std::cout << "fields separated with: " << DELIM << std::endl;

    //bool HEADER = true;
    if(HEADER == true)
    {
        std::cout << "dataset with header" << std::endl;
    }
    else
    {
        std::cout << "dataset without header" << std::endl;
    }

    //create object reader
    DataFileReader reader(FILENAME, DELIM, HEADER);
    //std::cout << reader.get_filename() << std::endl;

    //read data
    //reader.read_data_from_csv();

    return 0;
}
