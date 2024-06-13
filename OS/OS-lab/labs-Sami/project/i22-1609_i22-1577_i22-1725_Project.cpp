
#include <iostream>
#include<time.h>
#include<pthread.h>
#include<stdio.h>
#include<stdlib.h>	
#include<algorithm>
#include<sys/wait.h>
#include<semaphore.h>
#include <unistd.h>
#include <ctime>
using namespace std;


sem_t sem;
sem_t sem1;
sem_t sem2;


//structure for token
struct token{
	int value,x,y;//shows the x,y position and it's respective value
	bool open; //shows the state of token
	bool home;
	bool stop;
	bool win;
    char sym;
    token(){
        value=-1;
        x=0;
        y=0;
		stop=0;
		win=0;
		open=0;
		sym='!';
    }    
	token(int v,int x1,int y1,bool o,bool s,bool w,char sy){
		value=v;
        x=x1;
        y=y1;
		stop=s;
		win=w;
		open=o;
		sym=sy;
	}
	
};




pthread_t threadID2;
pthread_t ThreadID3;
int gotiyan = 4;


///
// structure of player
//	each player will have tokens ranging from 1-4 
///
struct player{
    
	//attributes
    token *goti;
	int hitRate;
	int withoutsixturns;
	bool is_win;
	bool inGame;
	//constructor
	player(){
		
		hitRate=1;
		is_win=0;
		inGame=1;
		withoutsixturns=0;
	}
	//parameterised constructor
	player(char symbol,int noOftokens ){
		
        goti = new token [noOftokens];
        for (int i=0;i<noOftokens;i++)
        {
            goti[i].sym=symbol;
        }
        
		hitRate=1;
		is_win=0;
		inGame=1;
		withoutsixturns=0;
	}
};


player player1;
player player2;
player player3;
player player4;
void *mthread(void *attr)
{
	
	cout << "Parent Thread\n";
	int temp = (*(int *)attr);
	player *currPlayer;
	// checking player
	if (temp == 1)
	{
		currPlayer = &player1;
		
	}
	else if (temp == 2)
	{
		currPlayer = &player2;
		
	}
	else if (temp == 3)
	{
		currPlayer = &player3;
		
	}
	else if (temp == 4)
	{
		currPlayer = &player4;
		
	}
	sem_wait(&sem2);
	for (int i = 0; i < gotiyan; i++)
	{
		if(currPlayer->goti[i].value==56){
			currPlayer->goti[i].win=1;
		}
		if (currPlayer->hitRate > 0 && currPlayer->goti[i].value >= 50)
		{
			currPlayer->goti[i].home = 1;
		}
		else
		{
			currPlayer->goti[i].home = 0;
		}
	}
	
	// checking without sixes ( i.e if a player plays 20 turns without sixes he will be removed from game )
	if (currPlayer->withoutsixturns >= 20)
	{
		currPlayer->inGame = 0;
	}
	bool notwinflag = 0;
	for (int i = 0; i < gotiyan; i++)
	{
		if (!currPlayer->goti[i].win)
		{
			notwinflag = 1;
		}
	}

	if (notwinflag == 0)
	{
		currPlayer->is_win = 1;
	}

	sem_post(&sem2);

	pthread_exit(NULL);
}
void gotiPath(int distance, token *tok)
{
    int attr;

    // checking players gotiyan
    if (tok->sym == '&')
    {
        attr = 1;
    }
    else if (tok->sym == '%')
    {
        attr = 2;
    }
    else if (tok->sym == '#')
    {
        attr = 3;
    }
    else if (tok->sym == '@')
    {
        attr = 4;
    }

    for (int i = 0; i < distance; i++)
    {
        sem_init(&sem2, 0, 1);
        // ceating master thread
        pthread_create(&ThreadID3, NULL, &mthread, &attr);
        pthread_join(ThreadID3, NULL);
        tok->value++;
        // checking if not home and then assingning respective positions to gotiyan
        if (!tok->home)
        {
            if (tok->y > 9 && tok->x == 6)
            {
                tok->y--;
            }
            else if (tok->y == 9 && tok->x == 6)
            {
                tok->y = 8;
                tok->x = 5;
            }
            else if (tok->y == 8 && tok->x > 0 && tok->x <= 5)
            {
                tok->x--;
            }
            else if (tok->x == 0 && tok->y > 6)
            {
                tok->y--;
            }
            else if (tok->y == 6 && tok->x < 5)
            {
                tok->x++;
            }
            else if (tok->x == 5 && tok->y == 6)
            {
                tok->y = 5;
                tok->x = 6;
            }
            else if (tok->y > 0 && tok->x == 6)
            {
                tok->y--;
            }
            else if (tok->y == 0 && tok->x < 8)
            {
                tok->x++;
            }
            else if (tok->y < 5 && tok->x == 8)
            {
                tok->y++;
            }
            else if (tok->x == 8 && tok->y == 5)
            {
                tok->y = 6;
                tok->x = 9;
            }
            else if (tok->x < 14 && tok->y == 6)
            {
                tok->x++;
            }
            else if (tok->x == 14 && tok->y < 8)
            {
                tok->y++;
            }
            else if (tok->x > 9 && tok->y == 8)
            {
                tok->x--;
            }
            else if (tok->x == 9 && tok->y == 8)
            {
                tok->y = 9;
                tok->x = 8;
            }
            else if (tok->x == 8 && tok->y < 14)
            {
                tok->y++;
            }
            else if (tok->x > 6 && tok->y == 14)
            {
                tok->x--;
            }
            if (tok->value > 51)
            {
                tok->value = (tok->value % 52);
            }
        }
        else
        {
            if (tok->sym == '&')
            {
                tok->x++;
            }
            else if (tok->sym == '#')
            {
                tok->y++;
            }
            else if (tok->sym == '%')
            {
                tok->y--;
            }
            else if (tok->sym == '@')
            {
                tok->x--;
            }
        }
    }
}

///
// draw the whole game scenarion or grid as well as gotiyan
///
void makegrid(int i, int j)
{
    if (i == 4 && j == 1 && !player1.goti[0].open && gotiyan>=1)
        cout << "\033[1;31m  &  \033[0m";
    else if (i == 4 && j == 4 && !player1.goti[1].open && gotiyan>=2)
        cout << "\033[1;31m  &  \033[0m";
    else if (i == 1 && j == 4 && !player1.goti[2].open && gotiyan>=3)
        cout << "\033[1;31m  &  \033[0m";
    else if (i == 1 && j == 1 && !player1.goti[3].open && gotiyan>=4)
        cout << "\033[1;31m  &  \033[0m";
    else if (i == 10 && j == 1 && !player2.goti[0].open && gotiyan>=1)

        cout << "\033[1;32m  %  \033[0m";
    else if (i == 10 && j == 4 && !player2.goti[1].open && gotiyan>=2)
        cout << "\033[1;32m  %  \033[0m";
    else if (i == 13 && j == 1 && !player2.goti[2].open && gotiyan>=3)
        cout << "\033[1;32m  %  \033[0m";
    else if (i == 13 && j == 4 && !player2.goti[3].open && gotiyan>=4)
        cout << "\033[1;32m  %  \033[0m";
    else if (i == 1 && j == 10 && !player3.goti[0].open && gotiyan>=1)
        std::cout << "\033[1;33m  #  \033[0m";
    else if (i == 1 && j == 13 && !player3.goti[1].open && gotiyan>=2)
        std::cout << "\033[1;33m  #  \033[0m";
    else if (i == 4 && j == 10 && !player3.goti[2].open && gotiyan>=3)
        std::cout << "\033[1;33m  #  \033[0m";
    else if (i == 4 && j == 13 && !player3.goti[3].open && gotiyan>=4)
        std::cout << "\033[1;33m  #  \033[0m";
    else if (i == 10 && j == 10 && !player4.goti[0].open && gotiyan>=1)
        cout << "\033[34m  @  \033[0m";
    else if (i == 10 && j == 13 && !player4.goti[1].open && gotiyan>=2)
        cout << "\033[34m  @  \033[0m";
    else if (i == 13 && j == 10 && !player4.goti[2].open && gotiyan>=3)
        cout << "\033[34m  @  \033[0m";
    else if (i == 13 && j == 13 && !player4.goti[3].open && gotiyan>=4)
        cout << "\033[34m  @  \033[0m";
    else if (i == player1.goti[0].y && j == player1.goti[0].x && player1.goti[0].open  && gotiyan>=1)
        cout << "\033[1;31m  &  \033[0m";
    else if (i == player1.goti[1].y && j == player1.goti[1].x && player1.goti[1].open && gotiyan>=2)
        cout << "\033[1;31m  &  \033[0m";
    else if (i == player1.goti[2].y && j == player1.goti[2].x && player1.goti[2].open && gotiyan>=3)
        cout << "\033[1;31m  &  \033[0m";
    else if (i == player1.goti[3].y && j == player1.goti[3].x && player1.goti[3].open && gotiyan>=4)
        cout << "\033[1;31m  &  \033[0m";
    else if (i == player2.goti[0].y && j == player2.goti[0].x && player2.goti[0].open && gotiyan>=1)
        cout << "\033[1;32m  %  \033[0m";
    else if (i == player2.goti[1].y && j == player2.goti[1].x && player2.goti[1].open && gotiyan>=2)
        cout << "\033[1;32m  %  \033[0m";
    else if (i == player2.goti[2].y && j == player2.goti[2].x && player2.goti[2].open && gotiyan>=3)
        cout << "\033[1;32m  %  \033[0m";
    else if (i == player2.goti[3].y && j == player2.goti[3].x && player2.goti[3].open && gotiyan>=4)
        cout << "\033[1;32m  %  \033[0m";
    else if (i == player3.goti[0].y && j == player3.goti[0].x && player3.goti[0].open && gotiyan>=1)
        std::cout << "\033[1;33m  #  \033[0m";
    else if (i == player3.goti[1].y && j == player3.goti[1].x && player3.goti[1].open && gotiyan>=2)
        std::cout << "\033[1;33m  #  \033[0m";
    else if (i == player3.goti[2].y && j == player3.goti[2].x && player3.goti[2].open && gotiyan>=3)
        std::cout << "\033[1;33m  #  \033[0m";
    else if (i == player3.goti[3].y && j == player3.goti[3].x && player3.goti[3].open && gotiyan>=4)
        std::cout << "\033[1;33m  #  \033[0m";
    else if (i == player4.goti[0].y && j == player4.goti[0].x && player4.goti[0].open && gotiyan>=1)
        cout << "\033[34m  @  \033[0m";
    else if (i == player4.goti[1].y && j == player4.goti[1].x && player4.goti[1].open && gotiyan>=2)
        cout << "\033[34m  @  \033[0m";
    else if (i == player4.goti[2].y && j == player4.goti[2].x && player4.goti[2].open && gotiyan>=3)
        cout << "\033[34m  @  \033[0m";
    else if (i == player4.goti[3].y && j == player4.goti[3].x && player4.goti[3].open && gotiyan>=4)
        cout << "\033[34m  @  \033[0m";

    else if (j < 5 && i < 5)
        cout << "     ";
    else if (j < 6 && i == 5)
        cout << " --- ";
    else if (j == 5 && i < 6)
        cout << "    |";
    else if (j < 5 && i > 9)
        cout << "     ";
    else if (j < 6 && i == 9)
        cout << " --- ";
    else if (j == 5 && i > 8)
        cout << "    |";
    else if (j > 9 && i < 5)
        cout << "     ";
    else if (j > 8 && i == 5)
        cout << " --- ";
    else if (j == 9 && i < 6)
        cout << "|     ";
    else if (j > 9 && i > 9)
        cout << "     ";
    else if (j > 8 && i == 9)
        cout << " --- ";
    else if (j == 9 && i > 8)
        cout << "|    ";
    else if (j == 1 && i == 6)
        cout << "  X  ";
    else if (j == 2 && i == 8)
        cout << "  X  ";
    else if (i == 7 && j > 0 && j < 6)
        cout << "\033[1;31m  X  \033[0m";
    else if (j == 6 && i == 2)
        cout << "  X  ";
    else if (j == 8 && i == 1)
        cout << "  X  ";
    else if (j == 7 && i > 0 && i < 6)
        cout << "\033[1;33m  X  \033[0m";
    else if (j == 6 && i == 13)
        cout << "  X  ";
    else if (j == 8 && i == 12)
        cout << "  X  ";
    else if (j == 7 && i > 8 && i < 14)
        cout << "\033[1;32m  X  \033[0m";
    else if (j == 13 && i == 8)
        cout << "  X  ";
    else if (j == 12 && i == 6)
        cout << "  X  ";
    else if (i == 7 && j > 8 && j < 14)
        cout << "\033[34m  X  \033[0m";
    else if (i > 5 && j > 5 && j < 9 && i < 9)
        cout << "  H  ";

    else
        cout << "     ";
}
void draw_frame()
{
    for (int i = 0; i < 15; i++)
    {
        for (int j = 0; j < 15; j++)
        {

            // grid for four gotiyan
            if (gotiyan == 4)
            {
                makegrid(i, j);
                
            }
            else if (gotiyan == 3) // grid for 3 gotiyan
            {
                    makegrid(i,j);
                
            }
            else if (gotiyan == 2) // grid for 2 gotiyan
            {
                    makegrid(i,j);

            }
            else if (gotiyan == 1) // grid for 1 token
            {
                    makegrid(i,j);
                
            }
        }
        cout << endl
             << endl;
    }
}

int dice()
{
	srand (time(NULL));
	return rand()%6+1;
}

int x[4][3];
void* hitRatio(void * attr)
{
	//cout<<"hitRatio\n";
	int temp=(*(int*)attr);
	player * currPlayer;
	if(temp==1){
		currPlayer=&player1;
	}
	else if(temp==2){
		currPlayer=&player2;
	}
	else if(temp==3){
		currPlayer=&player3;
	}
	else if(temp==4){
		currPlayer=&player4;
	} 
    if(currPlayer->inGame && !currPlayer->is_win)
	{
		sem_wait(&sem1);
		for(int i=0;i<gotiyan;i++){
			if(currPlayer->goti[i].sym=='&')
			{
				for(int j=0;j<gotiyan;j++)
				{
					if(currPlayer->goti[i].x==player3.goti[j].x&&currPlayer->goti[i].y==player3.goti[j].y && player3.goti[j].open ==1 && player3.goti[j].stop!=1)
					{
						cout<<"player1 ne player3 ko mara 1"<<endl;
						player3.goti[j].value=-1;
						player3.goti[j].open=0;
						player3.goti[j].home=0;
						player3.goti[j].x=8;
						player3.goti[j].y=1;
						currPlayer->hitRate++;
					}
					if(currPlayer->goti[i].x==player4.goti[j].x &&currPlayer->goti[i].y==player4.goti[j].y && player4.goti[j].open==1 &&player4.goti[j].stop!=1)
					{
						cout<<"player1 ne player4 ko mara 1"<<endl;
						player4.goti[j].value=-1;
						player4.goti[j].open=0;
						player4.goti[j].home=0;
						player4.goti[j].x=13;
						currPlayer->hitRate++;
						player4.goti[j].y=8;
					}
					if(currPlayer->goti[i].x==player2.goti[j].x && currPlayer->goti[i].y==player2.goti[j].y && player2.goti[j].open==1 &&player2.goti[j].stop!=1)
					{
						cout<<"player1 ne player2 ko mara 1"<<endl;
						player2.goti[j].home=0;

						player2.goti[j].value=-1;
						player2.goti[j].open=0;
						player2.goti[j].x=6;
						currPlayer->hitRate++;
						player2.goti[j].y=13;
					}
				}
			}
			else if(currPlayer->goti[i].sym=='%')
			{
				for(int j=0;j<gotiyan;j++)
				{
					if(currPlayer->goti[i].x==player1.goti[j].x && currPlayer->goti[i].y==player1.goti[j].y&& player1.goti[j].open==1 && player1.goti[j].stop!=1)
					{
						cout<<"player2 ne player1 ko mara 1"<<endl;
						player1.goti[j].value=-1;
						currPlayer->hitRate++;
						player1.goti[j].home=0;
						player1.goti[j].open=0;
						player1.goti[j].x=1;
						player1.goti[j].y=6;
					}
					if(currPlayer->goti[i].x==player3.goti[j].x && currPlayer->goti[i].y==player3.goti[j].y && player3.goti[j].open==1  &&player3.goti[j].stop!=1)
					{
						cout<<"player2 ne player3 ko mara 1"<<endl;
						player3.goti[j].value=-1;
						player3.goti[j].home=0;
						player3.goti[j].open=0;
						currPlayer->hitRate++;
						player3.goti[j].x=8;
						player3.goti[j].y=1;
					}
					if(currPlayer->goti[i].x==player4.goti[j].x && currPlayer->goti[i].y==player4.goti[j].y && player4.goti[j].open==1  &&player4.goti[j].stop!=1)
					{
						cout<<"player2 ne player4 ko mara 1"<<endl;
						player4.goti[j].value=-1;
						player4.goti[j].open=0;
						currPlayer->hitRate++;
						player4.goti[j].home=0;
						player4.goti[j].x=13;
						player4.goti[j].y=8;
					}
				}
			}
			else if(currPlayer->goti[i].sym=='#')
			{
				for(int j=0;j<gotiyan;j++)
				{
					if(currPlayer->goti[i].x==player4.goti[j].x && currPlayer->goti[i].y==player4.goti[j].y && player4.goti[j].open==1  &&player4.goti[j].stop!=1)
					{
						cout<<"player3 ne player4 ko mara 1"<<endl;
						player4.goti[j].value=-1;
						player4.goti[j].open=0;
						player4.goti[j].home=0;
						player4.goti[j].x=13;
						currPlayer->hitRate++;
						player4.goti[j].y=8;
					}
					if(currPlayer->goti[i].x==player2.goti[j].x && currPlayer->goti[i].y==player2.goti[j].y && player2.goti[j].open==1  &&player2.goti[j].stop!=1)
					{
						cout<<"player3 ne player2 ko mara 1"<<endl;
						player2.goti[j].value=-1;
						player2.goti[j].open=0;
						currPlayer->hitRate++;
						player2.goti[j].home=0;
						player2.goti[j].x=6;
						player2.goti[j].y=13;
					}
					if(currPlayer->goti[i].x==player1.goti[j].x && currPlayer->goti[i].y==player1.goti[j].y && player1.goti[j].open==1  &&player1.goti[j].stop!=1)
					{
						cout<<"player3 ne player1 ko mara 1"<<endl;
						player1.goti[j].value=-1;
						currPlayer->hitRate++;
						player1.goti[j].home=0;
						player1.goti[j].open=0;
						player1.goti[j].x=1;
						player1.goti[j].y=6;
					}
				}
			}
			else if(currPlayer->goti[i].sym=='@')
			{
				for(int j=0;j<gotiyan;j++)
				{
					if(currPlayer->goti[i].x==player2.goti[j].x &&currPlayer->goti[i].y==player2.goti[j].y && player2.goti[j].open==1 && player2.goti[j].stop!=1)
					{
						cout<<"player4 ne player2 ko mara 1"<<endl;
						player2.goti[j].value=-1;
						player2.goti[j].open=0;
						player2.goti[j].x=6;
						currPlayer->hitRate++;
						player2.goti[j].home=0;
						player2.goti[j].y=13;
					}
					if(currPlayer->goti[i].x==player1.goti[j].x && currPlayer->goti[i].y==player1.goti[j].y  && player1.goti[j].open==1 &&player1.goti[j].stop!=1)
					{
						cout<<"player4 ne player1 ko mara 1"<<endl;
						player1.goti[j].value=-1;
						currPlayer->hitRate++;
						player1.goti[j].home=0;
						player1.goti[j].open=0;
						player1.goti[j].x=1;
						player1.goti[j].y=6;
					}
					if(currPlayer->goti[i].x==player3.goti[j].x && currPlayer->goti[i].y==player3.goti[j].y && player3.goti[j].open==1 && player3.goti[j].stop!=1)
					{
						cout<<"player4 ne player3 ko mara 1"<<endl;
						player3.goti[j].value=-1;
						currPlayer->hitRate++;
						player3.goti[j].open=0;
						player3.goti[j].home=0;
						player3.goti[j].x=8;
						player3.goti[j].y=1;
					}
				}
			}
		}
		sem_post(&sem1);
	}
pthread_exit(NULL);
}


void *playerthread(void *attr)
{

	int temp = (*(int *)attr);
	char tempsym;

	// checking players
	player *currPlayer;
	if (temp == 1)
	{
		currPlayer = &player1;
		tempsym = '&';
	}
	else if (temp == 2)
	{
		currPlayer = &player2;
		tempsym = '%';
	}
	else if (temp == 3)
	{
		currPlayer = &player3;
		tempsym = '#';
	}
	else if (temp == 4)
	{
		currPlayer = &player4;
		tempsym = '@';
	}
	sem_wait(&sem); // Semaphor WAIT
	// initializing dice value for all the players to 0
	for (int i = 0; i < 3; i++)
	{
		x[temp - 1][i] = 0;
	}
	bool threesix = true;
	for (int i = 0; i < 3; i++)
	{
		x[temp - 1][i] = dice();												 // assiging dice value
		cout << "dice value of player " << tempsym << " is: " << x[temp - 1][i] << endl; // priinting dice value
		sleep(1);
		// checking without six turns condition and incrementing value of variable withoutsixturns
		if (x[temp - 1][i] != 6)
		{
			currPlayer->withoutsixturns++;
		}
		else
		{
			currPlayer->withoutsixturns = 0;
		}

		if (x[temp - 1][i] != 6)
		{
			threesix = false;
			break;
		}
	}
	if (threesix)
	{ // checking 3 consective sixes condition
		for (int i = 0; i < 3; i++)
		{
			x[temp - 1][i] = 0; // assigning zero on 3 consective sixes
		}
	}

	for (int j = 0; j < 3 && x[temp - 1][j] > 0; j++)
	{
		int n = 1;
		bool flag = false;
		for (int i = 0; i < gotiyan; i++)
		{
			if (currPlayer->goti[i].open == 1)
			{
				flag = true;
			}
		}
		if (flag || x[temp - 1][j] == 6)
		{
			cout << "Enter which token you want to move for player: " << tempsym << " :";
			cin >> n;

			while (n > gotiyan || n < 1)
			{
				cout << "Enter value between 0 to " << gotiyan + 1 << "::";
				cin >> n;
			}

			if (currPlayer->goti[n - 1].value == 56)
			{
				cout << "Token reached the end! Player " << tempsym << " has won!" << endl;
				break; // Terminate the player's turn
			}

			while (((!currPlayer->goti[n - 1].open) && x[temp - 1][j] != 6) || (currPlayer->goti[n - 1].win))
			{
				cout << "Please Enter value of opened token::";
				cin >> n;
			}
			bool winflag = 0;
			bool notmoveflag = 0;
			while (currPlayer->goti[n - 1].value + x[temp - 1][j] > 56)
			{
				cout << "You can not Move this token" << endl;

				for (int k = 0; k < gotiyan; k++)
				{
					if (k != n - 1)
					{
						if (!currPlayer->goti[k].win && currPlayer->goti[k].open)
						{
							winflag = 1;
						}
						if (x[temp - 1][j] == 6 && !currPlayer->goti[k].open)
						{
							winflag = 1;
						}
					}
				}
				if (winflag)
				{
					cout << "Enter another token" << endl;
					cin >> n;
				}
				else
				{
					notmoveflag = 1;
					break;
				}
			}

			if (currPlayer->goti[n - 1].open && !notmoveflag)
			{
				gotiPath(x[temp - 1][j], &currPlayer->goti[n - 1]);
			}
			else if (x[temp - 1][j] == 6)
			{

				currPlayer->goti[n - 1].value = 0;
				currPlayer->goti[n - 1].open = 1;
				if (currPlayer->goti[n - 1].sym == '&')
				{
					currPlayer->goti[n - 1].x = 1;
					currPlayer->goti[n - 1].y = 6;
				}
				else if (currPlayer->goti[n - 1].sym == '%')
				{
					currPlayer->goti[n - 1].x = 6;
					currPlayer->goti[n - 1].y = 13;
				}
				else if (currPlayer->goti[n - 1].sym == '#')
				{
					currPlayer->goti[n - 1].x = 8;
					currPlayer->goti[n - 1].y = 1;
				}
				else if (currPlayer->goti[n - 1].sym == '@')
				{
					currPlayer->goti[n - 1].x = 13;
					currPlayer->goti[n - 1].y = 8;
				}
			}

			if (currPlayer->goti[n - 1].value == 56)
			{
				cout << "Token reached the end! Player " << tempsym << " has won!" << endl;
				break; // Terminate the player's turn
			}
			// safe points conditions
			if (currPlayer->goti[n - 1].value == 0 || currPlayer->goti[n - 1].value == 8 || currPlayer->goti[n - 1].value == 13 || currPlayer->goti[n - 1].value == 21 || currPlayer->goti[n - 1].value == 26 || currPlayer->goti[n - 1].value == 34 || currPlayer->goti[n - 1].value == 39 || currPlayer->goti[n - 1].value == 47)
			{
				currPlayer->goti[n - 1].stop = 1;
			}
			else
			{
				currPlayer->goti[n - 1].stop = 0;
			}
		}

		for (int i = 0; i < gotiyan; i++)
			cout << "position value of token: " << i + 1 << " of player: " << tempsym << " is : " << currPlayer->goti[i].value << endl;
		cout << endl;

		sem_init(&sem1, 0, 1);
		pthread_create(&threadID2, NULL, &hitRatio, &temp);
		pthread_join(threadID2, NULL);
		//add system clear function
		cout<<"\nPress [ENTER] to clear board.\n";
		cin.ignore();
		system("clear");
		draw_frame();
	}
	sem_post(&sem);
	pthread_exit(NULL);
}



int main(void)
{ 
	//asking about the number of gotiyan
    do
	{
		cout<<"Enter the number of Tokens for each player from 1-4 :";
    	cin>>gotiyan;
	} while (gotiyan<1 || gotiyan>4);
	
	//creating four players
	player red('&',gotiyan);
	player green('%',gotiyan);
	player yellow('#',gotiyan);
	player blue('@',gotiyan);
	
	player1=red;
	player2=green;
	player3=yellow;
	player4=blue;

	//creating an array for random turns
	int turn[4]={1,2,3,4};	
	while(1){
		sem_init(&sem,0,1);	
		random_shuffle(turn,turn+4);
		cout<<"\nPress [ENTER] to start next round of moves.\n";
		cin.ignore();  
		pthread_t tid[4];
		
       

		//creating 4 threads each for one player
		for(int i=0;i<4;i++){
			pthread_create(&tid[i],NULL,&playerthread,&turn[i]);
			
		}
		//joing 4 threads
		for(int i=0;i<4;i++){
			pthread_join(tid[i],NULL);

		}
		
	}    
    return 0;
}
