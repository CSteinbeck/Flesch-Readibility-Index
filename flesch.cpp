#include <iostream>
#include <fstream>
#include <sstream>
#include <cstring>
#include <unordered_map>
#include <vector>
#include <cmath>
using namespace std;

//Checks if the character is a vowel
bool IsVowel (char letter)
{
if(letter == 'a' || letter == 'e' || letter == 'i' || letter == 'o' || letter == 'u' || letter =='y')
{
    return true;
}
return false;
} 


//Method to count the syllables in each word
int syllableCount( std::string word ) 
{
    int count = 0;
    char state = 'x';
    for (auto x : word ) 
    {
        switch(state) 
        {
        case 'x': 
        {
            break;
        }
        case 'v': 
        {
            if (!IsVowel(x))
            {
                count++;
            };
            break;
        }
        }
        state = IsVowel(x)?'v':'x';
    }
            if (state == 'v') 
            {
                count++;
            }
            return count;
  }

//Checks if the value is an integer
bool isNum(string token)
{
    for (int i = 0; i < token.length(); i++)
    {
        if (isdigit(token[i]) == false)
        { 
            return false;
        } 
    }
    return true; 
}

//Main Function
int main()
{

    //Command to input file location
    cout<<"Please enter specific file locations for translations:  "<<endl;
    string input;
    cin>>input;



//////////Storage
    //Checks if the file has opened
    ifstream BibleFile(input);
    BibleFile.open(input);
        if(BibleFile.fail())
        {
            cout<<"File cannot be accessed, please try again"<<endl;
        }
            //Imports the Dale-Chall List of Dif
    ifstream dalechall("/pub/pounds/CSC330/dalechall/wordlist1995.txt");
    	if (dalechall.is_open())
        {
		    cout << "The Dale-Chall list opened correctly." << endl;
        }
	    else 
        {
            cout << "Unable to open Dale-Chall list of words." << endl; 
        }


           //Creation of Storage for the Translations
            vector<string> vals;
            string tmp;
            
        while(getline(BibleFile,tmp))
        {
            stringstream s1(tmp);
            while(getline(s1,tmp,' '))
            {
                vals.push_back(tmp);
            }
        }
    unordered_map <string,int> dcStorage; //Storage for the Dale-Chall List
    string temp;
    int iteration=0;
    for(dalechall >> temp)
    {
        iteration++;
        for(int i=0;i<temp.size();i++)  
        {
            if(ispunct(temp[i]))
            {
                temp.erase(i--,1); //Removes the value if happens to be puncuation
            }
            temp[i]=tolower(temp[i]);
        } 
        dcStorage.insert(make_pair(temp, iteration)); //Inserts Map Pairing for value and placement
    }

    int word=0;
    int syllables=0;
    int sentence=0;
    int difficultWord=0;

    for(int i=0;i<vals.size();i++)
    {
        string instance = vals[i];
        
        if(!isNum(instance))
        {
            word++;
        } //Checks if the parameter passed in is a number

        for(int j=0;j<instance.length();i++)
        {
            char punc= instance[j];
            if(punc == '.' || punc =='?' || punc =='!' || punc ==';'|| punc ==':')
            {
                sentence++;
                instance = instance.substr(0,instance.length()-1); //Decreases the amount of items in the vector
            }
            syllable= syllable+ syllableCount(instance);
        }
    }

	cout << "Word count: " << word << endl;	
	cout << "Sentence count: " << sentence << endl;
	cout << "Syllable count: " << syllable << endl;
	cout << "Difficult Word count: " << difficultWord << endl;

	double alpha = ((double)syllable / (double)word);
	double beta = ((double)word / (double)sentence);
	double gamma = ((double)difficultWord / (double)word) * 100;

	double index = (206.835 - (alpha * 84.6) - (beta * 1.015));
	double grade = ((alpha * 11.8) + (beta * 0.39) - 15.59);

	cout << "The Flesch index score is: " << round(index) << endl;
	cout << "The Flesch Kincaid Grade Level index is: " << grade << endl;

	double readability;

	if (gamma > 5.0)
		readability = (gamma * 0.1579) + (beta * 0.0496) + 3.6365;
	else
		readability = (gamma * 0.1579) + (beta * 0.0496);

	cout << "The Dale-Chall Readability score is: " << readability << endl; 

	BibleFile.close();	

	return 0;
}















