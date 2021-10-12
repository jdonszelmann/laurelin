#![no_std]
#![no_main]
#![feature(lang_items)]

use core::panic::PanicInfo;

mod ipc;
mod proc;
mod vm;


#[panic_handler]
fn panic_handler(info: &PanicInfo) -> ! {

    loop {}
}

#[no_mangle]
fn kernel_main() {
    loop {
        unsafe { riscv::asm::wfi() }
    }
}

#[lang="eh_personality"]
fn eh_personality_handler() {

}
