// ConsoleApplication36.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include "pch.h"
#include <iostream>
#include <cstdlib>
#include "queue.h"
#include <ctime>
const int MIN_PER_HR = 60;

bool newcustomer(double x);

int main()
{
	using std::cin;
	using std::cout;
	using std::endl;
	using std::ios_base;

	std::srand(std::time(0));
	cout << "Case study: Bank of Heather Automatic Teller\n";
	cout << "Enter maximum size of queue: ";
	int qs;
	cin >> qs;
	Queue line(qs);
	Queue line_2(qs);
	cout << "Enter the number of simulation hours: ";
	int hours;
	cin >> hours;
	long cyclelimit = MIN_PER_HR * hours;
	cout << "Enter the average number of customers per hour: ";
	double perhour;
	cin >> perhour;
	double min_per_cust;
	min_per_cust = MIN_PER_HR / perhour;
	Item temp, temp_2;
	long turnaways = 0;
	long customers = 0;
	long served = 0;
	long sum_line = 0;
	int wait_time = 0;
	int wait_time_2 = 0;
	long line_wait = 0;

	for (int cycle = 0; cycle < cyclelimit; ++cycle)
	{
		if (newcustomer(min_per_cust))
		{
			if (line.isfull())
				++turnaways;
			else
			{
				++customers;
				temp.set(cycle);
				temp_2.set(cycle);
				if (line.quecount() <= line_2.quecount())
					line.enqueue(temp);
				else
					line_2.enqueue(temp_2);
			}
		}
		if (wait_time <= 0 && !line.isempty())
		{
			line.dequeue(temp);
			wait_time = temp.ptime();
			line_wait += cycle - temp.when();
			++served;
		}

		if (wait_time_2 <= 0 && !line_2.isempty())
		{
			line_2.dequeue(temp_2);
			wait_time_2 = temp_2.ptime();
			line_wait += cycle - temp_2.when();
			++served;
		}



		if (wait_time > 0)
		{
			--wait_time;
		}
		if (wait_time_2 > 0)
		{
			--wait_time_2;
		}

		sum_line += line.quecount() + line_2.quecount();
	}

	if (customers > 0)
	{
		cout << "customers accepted: " << customers << endl;
		cout << " customers served: " << served << endl;
		cout << "turnaways: " << turnaways << endl;
		cout << " average queue size: ";
		cout.precision(2);
		cout.setf(ios_base::fixed, ios_base::floatfield);
		cout << (double)sum_line / cyclelimit << endl;
		cout << "average wait time: "
			<< (double)line_wait / served << " minutes\n";
	}
	else
		cout << "No customers!\n";
	cout << "Done!\n";
	system("pause");
	return 0;
}


bool newcustomer(double x)
{
	return (std::rand() * x / RAND_MAX < 1);
}