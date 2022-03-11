#include <vector>
#include <iostream>
#include <fstream>
#include <stdio.h>
#include <time.h>

#include <thrust/host_vector.h>
#include <thrust/device_vector.h>
#include <thrust/generate.h>
#include <thrust/sort.h>
#include <thrust/copy.h>
#include <thrust/random.h>


void remap_func(thrust::host_vector<int>& h_idx) // remap the original indexes to continuous ones begining from 1
{
    int size = h_idx.size();

    thrust::host_vector<int> h_idx_No(size); 
    
    for(int i = 0; i < size; i++)
    {
        h_idx_No[i] = i;
    }

    // transfer to device 
    thrust::device_vector<int> d_idx = h_idx; 
    thrust::device_vector<int> d_idx_No =  h_idx_No; 
    
    // sort
    thrust::sort_by_key(d_idx.begin(), d_idx.end(), d_idx_No.begin()); 

    // transfer back to host 
    thrust::copy(d_idx.begin(), d_idx.end(), h_idx.begin()); 
    thrust::copy(d_idx_No.begin(), d_idx_No.end(), h_idx_No.begin()); 

    thrust::host_vector<int> h_idx_copy = h_idx; 

    int count = 1;
    int index= h_idx_No[0];
    h_idx[index] = count;
    
    for(int i = 1; i < size; i++)
    {
        int index= h_idx_No[i];
        int cur_val = h_idx_copy[i];
        int last_val = h_idx_copy[i-1];
        if(cur_val != last_val)
            count++;
        h_idx[index] = count;
    }

    return;

}


int main() 
{ 
    thrust::host_vector<int> h_keys; 

    h_keys.push_back(1);
    h_keys.push_back(5);
    h_keys.push_back(8);
    h_keys.push_back(5);
    h_keys.push_back(3);
    h_keys.push_back(1);

    for(int i=0 ; i<h_keys.size();i++)
        std::cout << h_keys[i]<<std::endl;
    
    std::cout <<std::endl;

    
    remap_func(h_keys);

    for(int i=0 ; i<h_keys.size();i++)
        std::cout << h_keys[i]<<std::endl;

    return 0; 
} 