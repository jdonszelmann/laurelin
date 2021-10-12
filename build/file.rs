use std::path::Path;
use std::collections::HashMap;

pub struct File {
    pub name: &'static str,
    pub out: &'static str,
    pub defines: HashMap<String, String>,
    pub nocompile: bool,
    pub pic: bool,
}

impl File {
    pub fn new(name: &'static str) -> Option<Self> {
        Some(Self {
            name,
            out: Path::new(name).file_stem()?.to_str()?,
            defines: HashMap::new(),
            nocompile: false,
            pic: false,
        })
    }

    pub fn define(mut self, key: impl Into<String>, value: impl Into<String>) -> Self {
        self.defines.insert(key.into(), value.into());
        self
    }

    pub fn output(mut self, name: &'static str) -> Self {
        self.out = name;
        self
    }

    pub fn nocompile(mut self) -> Self {
        self.nocompile = true;
        self
    }

    pub fn pic(mut self) -> Self {
        self.pic = true;
        self
    }
}
