//letter
#define ID  1;

//several brackets
#define OCB 2;
#define CCB 3;
#define OSB 4;
#define CSB 5;
#define OB  6;
#define CB  7;

//pipe separator
#define SEP 8;

//eq
#define EQ  9;

//optionString
#define OSTR 10; //later

//separators
// \n \t " "
// IGNORED

// ;
#define SC 11;

//multipliers
// *
#define Q   12;
#define NUM 13;

//block sep "|" but in {} context
#define BLSEP 14;

// - examples
//
// - i;s;s;f;f;f;f;         //identifiers
// - i;s*2;f*10;            //multipliers
// - i[val1|val2|val3];s;s; //parameters
// - f[val1|val2|val3]*3;   //complex repetitions
// - f{s;s;s;};             //nesting
