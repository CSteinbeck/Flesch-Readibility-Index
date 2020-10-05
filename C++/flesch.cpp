//Colton Steinbeck//
//Flesh Readibilty In C++//
#include <iostream>
#include <fstream> //Reading the 
#include <cstring>
#include <unordered_map> //Used for Dale-Chall
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



//String Cleanup 
string stringCleanup(string word)
{
    string tmp = "";
    for(int i=0; i<word.size();i++)
    {
        
        tolower(word[i]);
        if(isalpha(word[i]))
        {
            tmp+=(word[i]);
        }
    }
    return tmp;
}

//Method to count the syllables in each word
int syllableCount( string token ) 
{
int syllable = 0;
    bool found=false;
        
    for(int i = 0; i < token.length(); i++)
    
    {
    //Breaks down word to the char letter
    char letter=token[i];
    tolower(letter); //lowercases it
        if(IsVowel(letter)==true) //Checks using IsVowel method
        {
        found=true;
        syllable++;
            if(i+1<token.length()) //As long as the next letter doesn't exceed the length of the word
            {
                char nextLetter=token[i+1];
                nextLetter=tolower(nextLetter);
                if(IsVowel(nextLetter)==true) //As long as the current letter is a vowel and the next letter is not a vowel
                {
                    syllable--;
                
                }  
            }
        }
        //2nd Case- Deals with 'e' at the end of the word//
        if( (letter== 'e') && (i+1>token.size()))
        {
            syllable--;
        }
    
    }
            //3rd Case- If it claims there is no syllable
            if(found==false)
            {
                syllable++;
            }
            
            found=false;
            return syllable;
}

//Checks if the value is an integer
bool isNum(string token)
{
    int count=0;
for(int i=0;i<token.size();i++)
{
    if(isdigit(token[i])) //If char is a digit
    {
        count++;
        
    }
}
    if(count==token.size()) //Last Char check
    {
        return true;
    }
    return false;
}

void debug(int n) //Debugging Method
{
    cout << "we made it to " << n << "!" << endl;
}

//Main Function/////
int main()
{

    //Command to input file location
    cout<<"Please enter specific file locations for translations:  "<<endl;
    string input;
    cin>>input;

    //Checks if the file has opened
    ifstream BibleFile(input);
        //Error Handling//
        if (BibleFile.is_open())
        {
		    cout << "The Bible Translation opened correctly." << endl;
        }
        if(BibleFile.fail())
        {
            cout<<"File cannot be accessed, please try again"<<endl;
        }
            //Imports the Dale-Chall List of Difficult Words
    ifstream dalechall("/pub/pounds/CSC330/dalechall/wordlist1995.txt");
    	if (dalechall.is_open())
        {
		    cout << "The Dale-Chall list opened correctly." << endl;
        }
	    else 
        {
            cout << "Unable to open Dale-Chall list of words." << endl; 
        }


    //Creation of Vectors for the Translations
    vector<string> vals;
    string tmp;
    while(BibleFile >> tmp) 
    {
        vals.push_back(tmp); //Adds vals of the translation to the vector
    }
    unordered_map <string,int> dcStorage; //Storage for the Dale-Chall List
    string temp;
    int iteration=0;
    while(dalechall >> temp)
    {
        iteration++;
        for(int i=0;i<temp.size();i++)  
        {
            if(ispunct(temp[i]) && isalpha(temp[i])) //Punctuation and Alpha-Numeric Check
            {
                temp.erase(i--,1);//Removes the value if happens to be puncuation
            }
            temp[i]=tolower(temp[i]); //lowercases the words in Dale-
        } 
        dcStorage.insert(make_pair(temp, iteration)); //Inserts Map Pairing for value and placement
        
    }

    int word=0;
    int syllable=0;
    int sentence=0;
    int diffWord=0;

    //Looping through the vector for the translation
    for(int i=0; i<=vals.size()-1; i++)
    {
            string token = vals[i]; //Breaks down word by word
        try
        { //Try-Catch to make sure there is no OutOfBounds Exceptions
             
            //Sentence Check
           for(int j=0; j<=token.length();j++)
           {
               tolower(token[j]); //Lowercase each letter
               char punc = token[j];
               if(punc == '.' || punc =='!' || punc == '?' || punc == ':' || punc == ';' )
               {
                    sentence++;
               }
            }
        }
        catch(int e)
        {
    
        } 
        if (!isNum(token)) //Check if the word is a number
        {
         
            word++;
        
            syllable = syllable + syllableCount(token); //Checks using the syllable method
            token= stringCleanup(token); //Using method to help make more accurate of token
            if(dcStorage.find(token) == dcStorage.end()) //Checks the word to the DC List
            {
                diffWord++;
                
            }
        }
    }

    //Numeric Calculations
	cout << "Word count: " << word << endl;	
	cout << "Sentence count: " << sentence << endl;
	cout << "Syllable count: " << syllable << endl;
	cout << "Difficult Word count: " << diffWord << endl;

	double alpha = ((double)syllable / (double)word);
	double beta = ((double)word / (double)sentence);
	double gamma = ((double)diffWord / (double)word) * 100;

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

    //Closes the file after it is used
	BibleFile.close();	

	return 0;
}















