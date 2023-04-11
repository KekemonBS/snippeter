//letter
#define ID  100;

//several brackets
#define OCB 1;
#define CCB 2;
#define OSB 3;
#define CSB 4;
#define OB  5;
#define CB  6;

//pipe separator
#define SEP 7;

//eq
#define EQ  8;

//optionID
#define OID 9; //later

//separators
// \n \t " "
// IGNORED

// ;
#define SC 10;

//multipliers
// *
#define Q   11;


// - examples
//
// - issffff;              //identifiers
// - i;s*2;f*10;           //multipliers
// - i[val1|val2|val3];ss; //parameters
// - f[val1|val2|val3]*3;  //complex repetitions
// - f{sss};               //nesting
