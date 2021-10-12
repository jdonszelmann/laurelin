mod file;

use cc;
use file::File;

fn main() {
    let files = vec![
        File::new("src/asm/entry.S").unwrap(),
        File::new("linker/link.ld").unwrap().nocompile(),
        File::new("build/build.rs").unwrap().nocompile(),
    ];


    // Tell Cargo that if the given file changes, to rerun this build script.
    println!("cargo:rerun-if-changed={}", files.iter().map(|i| i.name).collect::<Vec<_>>().join(","));
    // Use the `cc` crate to build an assembly file and statically link it.
    for i in files {
        if i.nocompile {
            continue
        }

        let mut c = cc::Build::new();
        c.target("riscv64gc-unknown-none-elf");
        c.file(i.name);
        c.flag("-mabi=lp64");

        if i.pic {
            c.pic(true);
        } else {
            c.pic(false);
        }

        for (key, value) in i.defines {
            c.define(&key, Some(value.as_str()));
        }

        c.compile(i.out);
    }

}
