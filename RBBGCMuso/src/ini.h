/*
ini.h
Peter Thornton, NTSG
8/6/93

Header file for functions that read *.ini files and either 
store values in variables or open files for input or output 
General *.ini file format:
value/string	(whitespace)	comment, not required (\n)
*/



/* structure definition for filename handling */
typedef struct {
	char name[128];
	FILE *ptr;
} file;

/* function prototypes */
int file_open (file *target, char mode);
int scan_value (file ini, void *var, char mode);
int scan_open (file ini,file *target,char mode);


/* file_open is the generic file opening routine using the file structure
defined above */
int file_open (file *target, char mode)
/*	Possible values for mode
	'r' for read binary
    'i' for read ascii
    'w' for write binary
    'o' for write ascii
*/
{
	int ok=1;

	switch (mode)
	{
        case 'r':
            if ((target->ptr = fopen(target->name,"rb")) == NULL)
            {
                printf("Can't open %s for binary read ... Exiting\n",target->name);
                ok=0;
            }
            break;

        case 'i':
            if ((target->ptr = fopen(target->name,"r")) == NULL)
            {
                printf("Can't open %s for ascii read ... Exiting\n",target->name);
                ok=0;
            }
            break;

        case 'w':
            if ((target->ptr = fopen(target->name,"wb")) == NULL)
            {
                printf("Can't open %s for binary write ... Exiting\n",target->name);
                ok=0;
            }
            break;

        case 'o':
            if ((target->ptr = fopen(target->name,"w")) == NULL)
            {
                printf("Can't open %s for ascii write ... Exiting\n",target->name);
                ok=0;
            }
            break;

        default:
            printf("Invalid mode specification for file_open ... Exiting\n");
            ok=0;
    }
    return(!ok);
}


/* scan_value is the generic ascii input function for use with text
initialization files. Reads the first whitespace delimited word on a line,
and discards the remainder of the line. Returns a value depending on the
specified scan type */
int scan_value (file ini, void *var, char type)
/* Possible values for type
    'i' for integer
    'd' for double
    's' for string
*/

{
    int ok_scan;
    int ok=1;

    switch (type)
    {
        case 'i':
            ok_scan = fscanf(ini.ptr, "%d%*[^\n]",(int*)var);
            if (ok_scan == 0 || ok_scan == EOF) 
			{
				printf("Error reading int value from %s ... exiting\n",ini.name);
				ok=0;
			}
            break;

        case 'd':
            ok_scan = fscanf(ini.ptr, "%lf%*[^\n]",(double*)var);
            if (ok_scan == 0 || ok_scan == EOF)
			{
				printf("Error reading double value from %s... exiting\n",ini.name);
				ok=0;
			}
            break;

        case 's':
            ok_scan = fscanf(ini.ptr, "%s%*[^\n]",(char*)var);
            if (ok_scan == 0 || ok_scan == EOF) 
			{
				printf("Error reading string value from %s... exiting\n",ini.name);
				ok=0;
			}
            break;

        default:
            printf("Invalid type specifier for scan_value ... Exiting\n");
            ok=0;
    }
    return(!ok);
}

/* combines scan_value with file_open for reading a filename from an
initialization file and then opening it with a specified access mode */
int scan_open (file ini,file *target,char mode)
/* Possible values for mode
	'r' for read binary
	'i' for read ascii
	'w' for write binary
	'o' for write ascii
*/
{	
	int ok=1;

	if (scan_value(ini,target->name,'s'))
	{
		printf("Error reading filename from %s... Exiting\n",ini.name);
		ok=0;
	}
	if (ok)
	{
		if (file_open(target,mode))
		{
			ok=0;
		}
	}
	return(!ok);
}
