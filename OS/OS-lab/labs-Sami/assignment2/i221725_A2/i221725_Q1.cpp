#include <iostream>
#include <string>
#include <thread>

using namespace std;

struct Item
{
    string name;
    int quantity;
    int price;
};

// Function to calculate the sum of item prices
void calculateSum(const Item *items, int numItems, double &sum)
{
    sum = 0;
    for (int i=0;i<numItems;i++)
    {
        int itemPrice=items[i].quantity*items[i].price;
        sum+=itemPrice;
    }
}

// Function to calculate the tax on the sum
void calculateTax(double taxRate, double &sum)
{
    double tax=sum*taxRate;
    sum+=tax;
}

// Function to calculate the sale if the sum is above a threshold
void calculateSale(double saleRate, double &sum)
{
    if (sum>250)
    {
        double sale=sum*saleRate;
        sum-=sale;
    }
}

// Function to sort the items based on price
void sortItems(Item *items, int numItems)
{
    for (int i=0;i<numItems-1;i++)
    {
        for (int j=0;j<numItems-i-1;j++)
        {
            if (items[j].price>items[j+1].price)
            {
                swap(items[j], items[j+1]);
            }
        }
    }
}

int main()
{
    const int numItems = 5;
    Item items[numItems] = {{"eggs", 0, 15}, {"bread", 0, 60}, {"chocolate", 0, 50}, {"milk", 0, 30}, {"potatoes", 0, 20}};
    double taxRate = 0.08;
    double saleRate = 0.1;

    // Take input for the quantity of each item
    for (int i=0;i<numItems;i++)
    {
        cout << "Enter the quantity of " << items[i].name << ": ";
        cin >> items[i].quantity;
    }

    double sum = 0;

    // Create thread to calculate the sum
    thread t1(calculateSum, items, numItems, ref(sum));
    t1.join();

    // Create thread to calculate the tax
    thread t2(calculateTax, taxRate, ref(sum));
    t2.join();

    // Create thread to calculate the sale
    thread t3(calculateSale, saleRate, ref(sum));
    t3.join();

    // Create thread to sort the items
    thread t4(sortItems, items, numItems);
    t4.join();

    // Print the output
    cout << "\n\nThread 1:\n"
         << endl;
    cout << "Items Purchased = \n";
    for (int i=0;i<numItems;i++)
    {
        if (items[i].quantity>0)
        {
            cout<<items[i].name << ", ";
        }
    }
    cout<<endl;

    cout<<"Thread 2:\n"<<endl;
    cout<<"price = "<<sum<<endl;

    cout<<"Thread 3:\n"<<endl;
    if (sum>250)
    {
        cout<<"sale = "<<saleRate<<", "<<sum*saleRate<<endl<< endl;
        cout<< "price = "<<sum-(sum*saleRate)<<endl<< endl;
    }

    cout<<"Thread 4:\n"<<endl;
    cout<<"Items\t\tPrice"<<endl;
    for (int i=0;i<numItems;i++)
    {
        if (items[i].quantity>0)
        {
            cout<<items[i].name<<"\t\t"<<items[i].price<<endl;
        }
    }

    return 0;
}