//Sumador completo (full-adder) de tres entradas de 1 bit realizado a partir de puertas lógicas 
module fa(output wire sum, output wire c_out, input wire a, input wire b, input wire c_in);
	
	wire sum_out_1, carry1, carry2;

	ha_v1 semisumador1(sum_out_1, carry1, a, b);
	ha_v1 semisumador2(sum, carry2, c_in, sum_out_1);
	or or1(carry1, carry2); // Alternativa assign c_out = carry1 | carry2;
endmodule
