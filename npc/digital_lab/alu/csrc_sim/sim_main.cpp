#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vtop.h"
#include<stdio.h>


VerilatedContext* contextp = NULL;
VerilatedVcdC* tfp = NULL;

static Vtop* top;

void step_and_dump_wave(){
  top->eval();
  contextp->timeInc(1);
  tfp->dump(contextp->time());
}
void sim_init(){
  contextp = new VerilatedContext;
  tfp = new VerilatedVcdC;
  top = new Vtop;
  contextp->traceEverOn(true);
  top->trace(tfp, 0);
  tfp->open("wave.vcd");
}

void sim_exit(){
  step_and_dump_wave();
  tfp->close();
}

int main() {
  sim_init();

   top->A=0b0001;top->B=0b0101;top->crl=0b0;  step_and_dump_wave();   
                      top->crl=0b1;  step_and_dump_wave();   // 将b改为“1”，s和a的值不变，继续保持“0”，
             top->crl=0b10;  step_and_dump_wave();   // 将a，b分别改为“1”和“0”，s的值不变，
                      top->crl=0b11;  step_and_dump_wave();   // 将b改为“1”，s和a的值不变，维持10个时间单位
   top->crl=0b100;  step_and_dump_wave();   // 将s，a，b分别变为“1,0,0”，维持10个时间单位
                      top->crl=0b101;  step_and_dump_wave();
                      top->crl=0b110;  step_and_dump_wave();
                      top->crl=0b111;  step_and_dump_wave();
   
   top->A=0b1001;top->B=0b0101;top->crl=0b0;  step_and_dump_wave();
                      top->crl=0b1;  step_and_dump_wave();   // 将b改为“1”，s和a的值不变，继续保持“0”，
             top->crl=0b10;  step_and_dump_wave();   // 将a，b分别改为“1”和“0”，s的值不变，
                      top->crl=0b11;  step_and_dump_wave();   // 将b改为“1”，s和a的值不变，维持10个时间单位
   top->crl=0b100;  step_and_dump_wave();   // 将s，a，b分别变为“1,0,0”，维持10个时间单位
                      top->crl=0b101;  step_and_dump_wave();
                      top->crl=0b110;  step_and_dump_wave();
                      top->crl=0b111;  step_and_dump_wave();


  sim_exit();
}
