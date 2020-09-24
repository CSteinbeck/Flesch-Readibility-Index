#!/usr/bin/perl
use strict
#Pulls user input and stores it in a array
my $filename = $ARGV[0] or die "Please enter the translation you would like to evaluate.\n";
open(DATA, "<$filename") or die "Couldn't open file $filename, $!"; 
my @all_lines = <DATA>; 

our $sentence = 0;
our $word = 0;
our $syllabe =0;
our $diffWord =0;

foreach my $line (@all_lines) 
{
   my @tokens = split(' ', $line);
   foreach my $token (@tokens) 
   {
       $updated_token = lc($token) ##Lowercases the token
        ##print "$updated_token\n"; ##debug line
        foreach($updated_token ne $token + 0)
        {
            $word++;
        }
        my @characters =split('', $word);
        my $length = @characters;
        foreach $i(0..$#characters)

   }
} 