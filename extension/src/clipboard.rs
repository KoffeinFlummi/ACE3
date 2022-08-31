use arma_rs::Group;

#[cfg(feature = "clipboard")]
use clipboard::{ClipboardContext, ClipboardProvider};

pub fn group() -> Group {
    let mut group = Group::new();
    if cfg!(feature = "clipboard") {
        group = group
            .command("clear", clear)
            .command("append", append)
            .command("complete", complete)
    }
    group
}

static mut BUFFER: String = String::new();

#[cfg(feature = "clipboard")]
pub fn clear() {
    unsafe {
        BUFFER.clear();
    }
}

#[cfg(feature = "clipboard")]
pub fn append(text: String) {
    unsafe {
        BUFFER.push_str(&text);
    }
}

#[cfg(feature = "clipboard")]
pub fn complete() -> Result<(), String> {
    let mut ctx = ClipboardContext::new().map_err(|e| e.to_string())?;
    ctx.set_contents(unsafe { BUFFER.clone() })
        .map_err(|e| e.to_string())?;
    unsafe {
        BUFFER = String::new();
    }
    Ok(())
}
