use arma_rs::Group;
use clipboard::{ClipboardContext, ClipboardProvider};

pub fn group() -> Group {
    Group::new()
        .command("clear", clear)
        .command("append", append)
        .command("complete", complete)
}

static mut BUFFER: String = String::new();

pub fn clear() {
    unsafe {
        BUFFER.clear();
    }
}

pub fn append(text: String) {
    unsafe {
        BUFFER.push_str(&text);
    }
}

pub fn complete() -> Result<(), String> {
    let mut ctx = ClipboardContext::new().map_err(|e| e.to_string())?;
    ctx.set_contents(unsafe { BUFFER.clone() })
        .map_err(|e| e.to_string())?;
    unsafe {
        BUFFER = String::new();
    }
    Ok(())
}
