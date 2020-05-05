// #include "tle_device.h"
#include "Types.h"

/* externs defined in linker script */
extern uint32 _stext;
extern uint32 _etext;
extern uint32 _sbss;
extern uint32 _ebss;
extern uint32 _sdata;
extern uint32 _edata;
extern uint32 _sstack;
extern uint32 _estack;

/* Prototypes */
void Reset_Handler(void);								//Reset handler
void NMI_Handler(void);									//NMI exception handler
void HardFault_Handler(void);						//HardFault exception handler
void MemManage_Handler(void);						//MemoryManage exception handler
void BusFault_Handler(void);						//BusFault exception handler
void UsageFault_Handler(void);					//UsageFault exception handler
void SVC_Handler(void);									//SupervisorCall exception handler
void DebugMon_Handler(void);						//DebugMonitor exception handler
void PendSV_Handler(void);							//PendSV exception handler
void SysTick_Handler(void);							//SysTick exception handler

void GPT1_IRQHandler(void);
void GPT2_IRQHandler(void);
void ADC2_IRQHandler(void);
void ADC1_IRQHandler(void);
void CCU6SR0_IRQHandler(void);
void CCU6SR1_IRQHandler(void);
void CCU6SR2_IRQHandler(void);
void CCU6SR3_IRQHandler(void);
void SSC1_IRQHandler(void);
void SSC2_IRQHandler(void);
void UART1_IRQHandler(void);
void UART2_IRQHandler(void);
void EXINT0_IRQHandler(void);
void EXINT1_IRQHandler(void);
void BDRV_IRQHandler(void);
void DMA_IRQHandler(void);

extern int main(void);

/* Exception and interrupt vector table */
void (* const __Vectors[])(void) __attribute__((section(".vectors"))) =
{
    /* ARM Exceptions */
    (void*)(&_estack),
    Reset_Handler,
    NMI_Handler,
    HardFault_Handler,
    MemManage_Handler,
    BusFault_Handler,
    UsageFault_Handler,
    0,
    0,
    0,
    0,
    SVC_Handler,
    DebugMon_Handler,
    0,
    PendSV_Handler,
    SysTick_Handler,
    /* External Interrupts */
    GPT1_IRQHandler,
    GPT2_IRQHandler,
    ADC2_IRQHandler,
    ADC1_IRQHandler,
    CCU6SR0_IRQHandler,
    CCU6SR1_IRQHandler,
    CCU6SR2_IRQHandler,
    CCU6SR3_IRQHandler,
    SSC1_IRQHandler,
    SSC2_IRQHandler,
    UART1_IRQHandler,
    UART2_IRQHandler,
    EXINT0_IRQHandler,
    EXINT1_IRQHandler,
    BDRV_IRQHandler,
    DMA_IRQHandler
};

/* EXCEPTION & INTERRUPT HANDLERS */

void Reset_Handler(void)
{
    /* Copy init values from text to data */
    uint32 *init_values_ptr = &_etext;
    uint32 *data_ptr = &_sdata;

    if (init_values_ptr != data_ptr)
    {
        for (; data_ptr < &_edata;)
        {
            *data_ptr++ = *init_values_ptr++;
        }
    }

    /* Clear zero segment */
    for (uint32 *bss_ptr = &_sbss; bss_ptr < &_ebss;)
    {
        *bss_ptr++ = 0;
    }

    /* Go to main */
    // main();

    while (1) {}
}

void NMI_Handler(void)
{
    while(1) {}
}

void HardFault_Handler(void)
{
    while(1) {}
}

void MemManage_Handler(void)
{
    while(1) {}
}

void BusFault_Handler(void)
{
    while(1) {}
}

void UsageFault_Handler(void)
{
    while(1) {}
}

void SVC_Handler(void)
{
    while(1) {}
}

void DebugMon_Handler(void)
{
    while(1) {}
}

void PendSV_Handler(void)
{
    while(1) {}
}

void SysTick_Handler(void)
{
    while(1) {}
}

void GPT1_IRQHandler(void)
{
    while(1) {}
}

void GPT2_IRQHandler(void)
{
    while(1) {}
}

void ADC2_IRQHandler(void)
{
    while(1) {}
}

void ADC1_IRQHandler(void)
{
    while(1) {}
}

void CCU6SR0_IRQHandler(void)
{
    while(1) {}
}

void CCU6SR1_IRQHandler(void)
{
    while(1) {}
}

void CCU6SR2_IRQHandler(void)
{
    while(1) {}
}

void CCU6SR3_IRQHandler(void)
{
    while(1) {}
}

void SSC1_IRQHandler(void)
{
    while(1) {}
}

void SSC2_IRQHandler(void)
{
    while(1) {}
}

void UART1_IRQHandler(void)
{
    while(1) {}
}

void UART2_IRQHandler(void)
{
    while(1) {}
}

void EXINT0_IRQHandler(void)
{
    while(1) {}
}

void EXINT1_IRQHandler(void)
{
    while(1) {}
}

void BDRV_IRQHandler(void)
{
    while(1) {}
}

void DMA_IRQHandler(void)
{
    while(1) {}
}

