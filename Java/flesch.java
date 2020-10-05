//Colton Steinbeck//
//Flesh Readibilty In Java//
import java.lang.*;
import java.util.*;
import java.io.*;

public class flesch
{    

    public static void main(String[] args) throws IOException
    {
        //Takes the users command line input
    System.out.println("Please enter specific file locations for translations: ");
    Scanner tScan = new Scanner(System.in);
    String translations = tScan.nextLine();

    //Takes the file path puts these words into the array//
    Scanner scan = new Scanner(new File(translations));
     
    ArrayList<String> vals= new ArrayList<String>();
    
        while(scan.hasNext())
        {
            String words= scan.next();
            vals.add(words);
        
        }    
        //Pulls the Dale-Chall words into storage 
    Scanner dc = new Scanner(new File("/pub/pounds/CSC330/dalechall/wordlist1995.txt"));
    Map<String, Object> dcStorage = new HashMap<String,Object>();
        
        while(dc.hasNextLine()) 
        {
            String word = dc.nextLine();
            dcStorage.put(word, null);
        }

        //Instanties Variables
        int words = 0;
        int syllables = 0;
        int sentences = 0;
        int diffWord = 0;
 

        //Goes through the whole array of the Bible (Main Array)
        
        for(int i=0; i<=vals.size()-1; i++)
        {
            String token = vals.get(i);
            token = token.toLowerCase();
        try
        { //Try-Catch loop so there is no OutOfBoundsException for the ArrayList
             
            //Check for punctuation
           for(int j=0; j<=token.length();j++)
           {
               char punc = token.charAt(j);
               if(punc == '.' || punc =='!' || punc == '?' || punc == ':' || punc == ';' )
               {
                    sentences++;
               }
           }
        }
        catch(StringIndexOutOfBoundsException e)
        {
    
        } 
        if (!isNumber(token))
        {
           words++        
           syllables = syllables + syllableCount(token); 
            if(!dcStorage.containsKey(token))
            {
                diffWord++; 
            }
        }
        }
    //Numeric calculations
    System.out.println("Word count: " + words);
    System.out.println("Sentence count: " + sentences);
    System.out.println("Syllable count: " + syllables);
    System.out.println("Difficult Word count: " + diffWord);

    double alpha = ((double)syllables / (double)words);
    double beta = ((double)words / (double)sentences);
    double gamma = ((double)diffWord / (double)words);

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
    public static int syllableCount(String token)
    {
    int syllableCount=0;
    boolean found=false;
    //For each index until the length of the strin
    for(int i = 0; i < token.length(); i++)
    
    {
    
    char letter=token.charAt(i);
    letter=Character.toLowerCase(letter);
    
    
        //Checks if the letter is a vowel
        if(isVowel(letter)==true)
        {
        
        found=true;
        syllableCount++;
        
            if(i+1<token.length()) //if the next letter doesnt exceed the length of the string
            
            {
                char nextLetter=token.charAt(i+1); //Increments to the next letter
                nextLetter=Character.toLowerCase(nextLetter); //lowercase
                if(isVowel(nextLetter)==true) //if vowel is next letter
                {
                    syllableCount--;
                
                }
                
            }
        
        }
        //2nd Case: If the letter 'e' is the last character
        if( (letter== 'e') && (i+1>token.length()))
        {
            syllableCount--;
        }
    
    }
    
        if(found==false)
        {
            syllableCount++;
        }
            
    found=false;
    return syllableCount;
    }
    
    //Checks if the string passed is a integer
    private static boolean isNumber(String value)
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

 
}//End of Class