##Colton Steinbeck
##Flesch Readibility in Perl

#!/usr/bin/perl
use strict;
use warnings;

##User Input for the Bible Translation
my $filePath =$ARGV[0] or die "Please enter the file path for the translation:\n";
open(DATA, "<$filePath") or die "Couldn't open file $filePath, $!"; 
my @all_lines = <DATA>; 

##Import of Dale-Chall List
open(LINES, "</pub/pounds/CSC330/dalechall/wordlist1995.txt") or die "Couldn't open Dale-Chall list!\n";
my @dcStorage = <LINES>;

##Global Variables in Perl
my $sentences = 0;
my $words = 0;
my $syllables =0;
my $diffWordCount =0;

##Cycles through the Translations
foreach my $line (@all_lines) 
{
    ##Delimites the specific file by spaces
    my @vals = split(' ', $line);
    foreach my $tokens(@vals)
    {
    our $token =lc($tokens); ##Lowecase the words
    $words= $words+1; ##Increments the words
    my @char = split('', $tokens); #Splits it based on spaces
    my $length =@char;

        ##For each index in the word
        foreach my $i(0..$#char)
        {
            ##Sentence Check
            if ($char[$i] eq '.' || $char[$i] eq ':' || $char[$i] eq ';' || $char[$i] eq '!' || $char[$i] eq '?')
			{
				$sentences++;
			}

            my $watch = 0; ##Similar to the boolean value in other languages, keeps track of the placement of the character
			if ($char[$i] eq 'a' || $char[$i] eq 'i' || $char[$i] eq 'o' || $char[$i] eq 'u' || $char[$i] eq 'y')
			{
				if ($watch == 0) ##If false
				{
                    $syllables++;
				}
				$watch = 1;	##Resets Value to true
			}
            ##2nd Case (End of word 'e' case)
        	elsif ($char[$i] eq 'e')
			{
				if ($i == $length - 1) ##If last character is e
				{
					$syllables = $syllables;
				}

				if (($watch == 0) && ($i != $length - 1)) ##If False and the character is the next to last character##
				{
					$syllables++;
				}
				$watch = 1; ##Resets value to true
			}
        }
        my $watch2 =0;  ##Second boolean condition to the check if the word matches the DC word
        foreach my $j(0..$#dcStorage)
        {    
        chomp($dcStorage[$j]); ##Removes trailing lines values so spaces aren't accounted for
        if ($token eq $dcStorage[$j])
            {
                $watch2 =1;
            } 
        }
        if(not $watch2) 
        {
            $diffWordCount++;
        }
    }
}

##Results Printout
my $diffWord = $diffWordCount;

print"The word count is: $words\n";
print"The sentence count is: $sentences\n";
print"The syllable count is: $syllables\n";
print"The difficult word Count is: $diffWord\n";

our $alpha = ($syllables / $words);
our $beta = ($words / $sentences);
our $gamma = ($diffWord / $words);

our $flesch = 206.835 - ($alpha * 84.6) - ($beta * 1.015);
our $grade = ($alpha * 11.8) + ($beta * 0.39) - 15.59;
our $readability;
if ($gamma > 0.05)
{
	$readability = (($gamma * 100) * 0.1579) + ($beta * 0.0496) + 3.6365;
}

else
{
        $readability = (($gamma * 100) * 0.1579) + ($beta * 0.0496);
}

print"The Flesch Readability index is: $flesch\n";
print"The Flesch-Kincaid Grade Level index is: $grade\n";
print"The Dale-Chall Readability Score is: $readability\n";