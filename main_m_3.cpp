#include "matrices_3.hpp"

int main(void)
{
	matrix_t A;

	cout << endl;
	A.read(cin);
	cout << "---  MATRIZ ORIGINAL A ---" << endl;
	A.write();

	const matrix_t& B=A;

	cout << endl;
	cout << "---  MATRIZ ORIGINAL B ---" << endl;
	B.write();	
}
