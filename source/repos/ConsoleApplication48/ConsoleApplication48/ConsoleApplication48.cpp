#include "pch.h"
#include <iostream>
#include <string>
#include <stdlib.h>
#include <time.h>

class Person
{
private:
	std::string firstName;
	std::string lastName;
public:
	Person() : firstName("Unknown"), lastName("Unknown") {};
	Person(const std::string fn, const std::string ln) : firstName(fn), lastName(ln) {};
	virtual void Show() { std::cout << "First name: " << firstName << "\nLast name: " << lastName << std::endl; };
};



class Gunslinger : virtual public Person
{
private:
	double readyTime = 0.0;
	int deathCounter = 0;
public:
	Gunslinger() = default;
	Gunslinger(const std::string fn, const std::string ln, const double rt, const int dc) : Person(fn, ln), readyTime(rt), deathCounter(dc) {};
	double Draw() { return readyTime; };
	void Show()
	{
		std::cout << "The Gunslinger.\n";
		Person::Show();
		std::cout << "Ready time: " << readyTime << "\n Death counter: " << deathCounter << std::endl;
	}
};

class PokerPlayer : virtual public Person
{
private:
	int card = 0;

public:
	PokerPlayer() = default;
	PokerPlayer(const std::string fn, const std::string ln) : Person(fn, ln) {};
	int Draw() 
	{
		srand(time(NULL));
		card = rand() % 53;
		return card;
	}
	void Show()
	{
		std::cout << "The PokerPlayer:\n";
		Person::Show();
		std::cout << "The card is: " << card << std::endl;
	}
};


class BadDude : public Gunslinger, public PokerPlayer
{
private:
	double readyShoot = 0.0;
public:
	BadDude() = default;
	BadDude(const std::string fn, const std::string ln, const double rt, const int dc, const double rs) : Person(fn, ln), Gunslinger(fn, ln, rt, dc), PokerPlayer(fn, ln), readyShoot(rs) {};
	double Gdraw() { return readyShoot; };
	int Cdraw() { return PokerPlayer::Draw(); };
	void Show()
	{
		std::cout << "The BadDude:\n";
		Person::Show();
		std::cout << "Ready to shoot: " << readyShoot << "\nCard: " << PokerPlayer::Draw() << "\nReady state: " << Gunslinger::Draw() << std::endl;
	}
};







int main()
{

	BadDude man("Max", "Schlee", 15.4, 7, 2);

	man.Show();


	system("pause");
	return 0;
}

