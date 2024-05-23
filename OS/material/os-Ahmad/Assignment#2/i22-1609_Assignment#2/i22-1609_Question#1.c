#include <stdio.h>
#include <string.h>
#include <pthread.h>

struct Items{
    int price,quantity;
    char name[20];
};
int n;

int totalprice;
float taxedprice;

void *Total(struct Items *items){
    int total=0;
    for(int i=0;i<n;i++){
        total+=items[i].price*items[i].quantity;
    }
    printf("Total: %d\n",total);
    totalprice=total;
    
}

void *Tax(int total){
    float tax=0.08*total;

    printf("\nTax: %f\n",tax);
    taxedprice=total+tax;
    printf("\nTotal after tax: %f\n",taxedprice);
}


void *Discount(int total){
    float discount=0.1*total;
    printf("\nDiscount: %f\n",discount);
    taxedprice=taxedprice-discount;
    printf("\nTotal after discount: %f\n",taxedprice);
}

void *sort(struct Items *items){
     struct Items temp;
    for(int i=0;i<n;i++)
    {
        
        for(int j=i+1;j<n;j++)
        {
            if((items[i].price*items[i].quantity)<(items[j].price*items[j].quantity))
            {
                temp=items[i];
                items[i]=items[j];
                items[j]=temp;
            }
        }
        
    }

    printf("\n\nName\tPrice\n");
    for(int i=0;i<n;i++){
        printf("%s\t%d\n",items[i].name,items[i].price*items[i].quantity);
    }
}


int main()
{
    struct Items items[10];
    
    printf("Enter the number of items: ");
    scanf("%d",&n);
    for(int i=0;i<n;i++){
        printf("Enter the name of item %d: ",i+1);
        scanf("%s",items[i].name);
        printf("Enter the price of item %d: ",i+1);
        scanf("%d",&items[i].price);
        printf("Enter the quantity of item %d: ",i+1);
        scanf("%d",&items[i].quantity);
        printf("\n");
    }

    printf("\n\nName\tPrice\tQuantity\n");
    for(int i=0;i<n;i++){
        printf("%s\t%d\t%d\n",items[i].name,items[i].price,items[i].quantity);
    }

    pthread_t total;
    pthread_create(&total,NULL,Total,(void*)items);
    pthread_join(total,NULL);

    pthread_t tax;
    pthread_create(&tax,NULL,Tax,totalprice);
    pthread_join(tax,NULL);

    if(totalprice>250){
        pthread_t discount;
        pthread_create(&discount,NULL,Discount,totalprice);
        pthread_join(discount,NULL);
    }

    pthread_t sort1;
    pthread_create(&sort1,NULL,sort,(void*)items);
    pthread_join(sort1,NULL);
   
    return 0;



}