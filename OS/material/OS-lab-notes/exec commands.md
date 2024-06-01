
| Letters | Explanation                                                         |
| ------- | ------------------------------------------------------------------- |
| l       | argv is specified as a list of arguments                            |
| v       | argv is specified as a vector (array of character<br>pointers)      |
| e       | environment is specified as an array of charac-<br>ter pointers     |
| p       | PATH is searched for command, and command<br>can be a shell program |
## Prototypes of exec()

1. `int execl(const char * path, const char * arg, ...);`

2. `int execlp(const char * file, const char * arg, ...);`

3. `int execv(const char * path, char * const argv[]);`

4. `int execvp(const char * file, char * const argv[]);`

5. `int execle(const char * path, const char * arg, char * const envp[]);`

6. `int execve(const char * path, const char * argv[], char * const envp[]);`

## Examples
### execl

```
#include <unistd.h>
#include <sys/types.h> 
#include <sys/wait.h> 
#include <stdio.h> 
#include <errno.h> 
#include <stdlib.h>

int main(){
	pid_t childpid = fork ( ) ;
	if ( childpid ==0){
		printf("I am a child proce with pid = %d \n",getpid()); 
		printf("The next statement is execl and ls will run \n"); 
		execl("/bin/ls","ls", " -l", "/usr" ,NULL);
		printf("Execl failed");
		}
	else if ( childpid >0)
	{
	wait(NULL);
	printf("\n I am parent process with pid = %d and finished waiting \n" , getpid ( ) ) ;
	}
return 0;
}
```

```
#include <iostream>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    pid_t pid = fork();
    
    if (pid < 0) {
        std::cerr << "Fork failed" << std::endl;
        return 1;
    } else if (pid == 0) { // Child process
        execl("./child_program", "child_program", "arg1", "arg2", NULL);
        std::cerr << "Exec failed" << std::endl;
        return 1;
    } else { // Parent process
        wait(NULL); // Wait for the child to finish
        std::cout << "Child process completed" << std::endl;
    }
    
    return 0;
}
```

### execlp

```
#include <unistd.h> 
#include <sys/types.h> 
#include <sys/wait.h> 
#include <stdio.h> 
#include <errno.h> 
#include <stdlib.h>

int main(){
pid_t childpid = fork ( ) ;
	if ( childpid ==0){
		printf("I am a child proce with pid = %d \n",getpid()); 
		printf("The next statement is execlp and ls will run \n"); 
		execlp("ls" ,"ls" ,"−l" ,"/usr" ,NULL);
		printf("Execl failed");
		}
	else if ( childpid >0){
		wait(NULL);
		printf("\n I am parent process with pid = %d and finished waiting \n" , getpid ( ));
		}
return 0;
}
```
### execv

```
#include <unistd.h> 
#include <sys/types.h> 
#include <sys/wait.h> 
#include <stdio.h> 
#include <errno.h> 
#include <stdlib.h>

int main(){
	pid_t childpid = fork ( ) ;
	if ( childpid ==0){
		printf("I am a child proce with pid = %d \n",getpid()); 
		printf("The next statement is execv and ls will run \n"); 
		char* argv[]={"ls" ,"−l" ,"/usr" ,NULL};
		execv("/bin/ls" ,argv);
		printf("Execl failed");
		}
	else if ( childpid >0){
		wait(NULL);
		printf("\n I am parent process with pid = %d and finished waiting \n" , getpid ( ) ) ;
		}
return 0;
}
```
### execvp

```
#include <unistd.h> 
#include <sys/types.h> 
#include <sys/wait.h> 
#include <stdio.h> 
#include <errno.h> 
#include <stdlib.h>

int main(){
	pid_t childpid = fork ( ) ;
	if ( childpid ==0){
		printf("I am a child proce with pid = %d \n",getpid()); 
		printf("The next statement is execv and ls will run \n"); 
		char* argv[]={"ls" ,"−l" ,"/usr" ,NULL};
		execvp ( "ls",argv ) ;
		printf("Execl failed");
		}
	else if ( childpid >0){
		wait(NULL);
		printf("\n I am parent process with pid = %d and finished waiting \n" , getpid ( ) ) ;
		}
return 0; 
}
```
### execle

```
#include <unistd.h>
#include <sys/types.h> 
#include <sys/wait.h> 
#include <stdio.h> 
#include <errno.h> 
#include <stdlib.h>

int main(){
	pid_t childpid = fork ( ) ;
	if ( childpid ==0){
		printf("I am a child proce with pid = %d \n",getpid()); 
		printf("The next statement is execle\n"); 
		char *env[] = { "export TERM=vt100" , "PATH=/bin:/usr/bin" , NULL }; 
		execle("/bin/cat" , "cat" , "f1" , NULL, env);
		printf("Execl failed");
		}
	else if ( childpid >0)
	{
	wait(NULL);
	printf("\n I am parent process with pid = %d and finished waiting \n" , getpid ( ) ) ;
	}
return 0;
}
```
### execve

```
#include <unistd.h> 
#include <sys/types.h> 
#include <sys/wait.h> 
#include <stdio.h> 
#include <errno.h> 
#include <stdlib.h>

int main(){
	pid_t childpid = fork ( ) ;
	if ( childpid ==0){
		printf("I am a child proce with pid = %d \n",getpid()); 
		printf("The next statement is execv and ls will run \n"); 
		char *env[]={ "export TERM=vt100" , "PATH=/bin:/usr/bin" , NULL}; 
		char *args[]={ "cat", "f1", NULL };
		execve ( "/bin/cat" , args , env ) ;
		printf("Execl failed");
		}
	else if ( childpid >0){
		wait(NULL);
		printf("\n I am parent process with pid = %d and finished waiting \n" , getpid ( ) ) ;
		}
return 0;
}
```

