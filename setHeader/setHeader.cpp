//
//  main.cpp
//  bin2raw
//
//  Created by Tony Fruzza on 4/28/14.
//  Copyright (c) 2014 Lightspeed Systems. All rights reserved.
//

#include <iostream>
#include <string>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sstream>

#define FLAG_WIDTH_SET  0x01
#define FLAG_HEIGHT_SET 0x02
#define FLAG_FILE_SET   0x04

using namespace std;

int main(int argc, char * argv[]){
    int bytesRead, height, width;
    unsigned char readChar;
    size_t lastRead = 1;
    FILE *fp, *wfp;
    char ch;
    u_int8_t flags;
    string fileName;
    
    while((ch = getopt(argc, argv, "w:h:f:")) != -1){
        switch (ch){
            case 'w':
                flags |=  FLAG_WIDTH_SET;
                break;
            case 'h':
                flags |= FLAG_HEIGHT_SET;
                break;
            case 'f':
                flags |= FLAG_FILE_SET;
                fileName = optarg;
                break;
            default:
                cout << "unknown option." << endl;
        }
    }
    argc -= optind;
    argv += optind;

    if(!(flags & FLAG_FILE_SET)){
        cout << "Specify file to open" << endl;
        exit(1);
    }
    
    if(!(fp = fopen(fileName.c_str(), "rb"))){
        cout << "Could not open file: " << argv[1] << endl;
        return 1;
    }
    
    if(!(wfp = fopen("out.bin", "wb"))){
        cout << "Could not open file: out.bin for writing." << endl;
        return 1;
    }
    
    // Write header info needed for map
    u_int8_t w1 = 40, w2 = 0, h1 = 25, h2 = 0;
    fwrite(&w1, 1, 1, wfp);
    fwrite(&w2, 1, 1, wfp);
    fwrite(&h1, 1, 1, wfp);
    fwrite(&h2, 1, 1, wfp);
    
    while(!feof(fp) && lastRead > 0){
        if(!(lastRead = fread(&readChar, 1, 1, fp))){
            continue;
        }
        fwrite(&readChar, 1, 1, wfp);
        bytesRead++;
    }
    
    cout << "Bytes read: " << bytesRead << endl;
    
    fclose(fp);
    fclose(wfp);
    return 0;
}