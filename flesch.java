//Colton Steinbeck//
//Test comment for the file transfer on Anvil//
import java.lang.*;
import java.util. *;
import java.io.*;
import java.Scanner;

public class flesch
{    

    public static void main(Strings[] args) 
    {
        //Takes the users command line input
    System.out.println("Please enter specific file locations for translations: ");
    Scanner tScan = new Scanner(System.in);
    String translation = tScan.nextLine();

    //Takes the file path puts these words into the array//
    File translation = new File();
    Scanner scan = new Scanner(File(translation));
     
    ArrayList<String> vals= new ArrayList<String>();
    
        while(scan.hasNext())
        {
            String words= scan.next();
            vals.add(words);
        
        }


        
        //Pulls the Dale-Chall words into storage 
        Scanner dc = new Scanner(System.in("/pub/pounds/CSC330/dalechall"));
        Map<String, Object> dcStorage = new HashMap<String, Object>();
        
        while(dc.hasNextLine()) 
        {
            String word = dc.nextLine();
            word=word.toLowerCase();
            dcStorage.put(word,null);
        }

        int words = 0;
        int syllables = 0;
        int sentence = 0;


        //Goes through the whole array of the Bible (Main Arra)
        for(int i=0 ;i<=vals.size(); i++)
        {
            String token = vals.get(i);
            token = token.getLowerCase(); 
            
            //Check for punctuation
           for(int j=0; j<=token.length();j++)
           {
               char punc = token.charAt(j);
               if(punc == '.' || punc =='!' || punc == '?' || punc == ':' || punc == ';' )
               {
                    sentence++;
               }
               //Determines if the 
               if (!isInteger(token))
               {
                   word++;
                   syllables = syllables + numSyllables(token);
        
               }
        }


        







        }
        System.out.println("Word count: " + word);
		System.out.println("Sentence count: " + sentence);
		System.out.println("Syllable count: " + syllables);
		System.out.println("Difficult Word count: " + diffWord);

		double alpha = ((double)syllables / (double)word);
		double beta = ((double)word / (double)sentence);
		double gamma = ((double)diffWord / (double)word);

		double flesch = 206.835 - (alpha * 84.6) - (beta * 1.015);
		double grade = (alpha * 11.8) + (beta * 0.39) - 15.59;
		double readability;
        if (gamma > 0.05)
        {
            readability = ((gamma * 100.0) * 0.1579) + (beta * 0.0496) + 3.6365;
        }
        else
        {
            readability = ((gamma * 100.0) * 0.1579) + (beta * 0.0496);
        }

		System.out.println("The Flesch Readability index is: " + flesch);
		System.out.println("The Flesh-Kincaid Grade Level index is: " + grade);
		System.out.println("The Dale-Chall Readability Score is: " + readability);




    }
    //Checks if it is a vowel
    private static boolean isVowel(char letter)
    {
        return letter == 'a' || letter == 'e' || 
               letter == 'i' || letter == 'o' ||
               letter == 'u' || letter == 'y';
    }

    //Counts the number of syllables in the 
    private static int syllableCount(String word)
    {
       int syllableCount=0;
        char state= "x";
        // 1. Adjacent vowels to count as syllable  
        for(auto state : word)
        {
            switch(state)
            {
                case 'x':
                break;
                
                
                case 'v':
                {
                    if(!isVowel(x)) //Makes sure that count will not increment if there is a vowel next to it
                    {
                        syllableCount++;
                    }
                    break;
            }
            }   
            state = isVowel(x)? 'v':'x';
        }
         if(state=='v')
         {
             syllableCount++;
         }


            
            //2. Special Case with e at the end of the word
            if(letter == 'e' && i= word.length()-1)
            {
                i++;
            }
           

          else
          {
              
          } 
        


    }


    private static boolean isNumber(int value)
    {

        try 
        {
        Integer.parseInt(value);
        return true;    
        } 

        catch (Exception e) 
        {
            return false;
        }
    }
}