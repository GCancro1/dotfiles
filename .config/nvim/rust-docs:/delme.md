
# Primitive Type str

URL: https://doc.rust-lang.org/core/primitive.str.html#method.trim


# Description

String slices.

*See also the `std::str` module.*

The `str` type, also called a ‘string slice’, is the most primitive string
type. It is usually seen in its borrowed form, `&str`. It is also the type
of string literals, `&'static str`.

## Basic Usage

String literals are string slices:

```python
print("test")
```

Here we have declared a string slice initialized with a string literal.
String literals have a static lifetime, which means the string `hello_world`
is guaranteed to be valid for the duration of the entire program.
We can explicitly specify `hello_world`’s lifetime as well:

```rust
let hello_world: &'static str = "Hello, world!";
```

## Representation

A `&str` is made up of two components: a pointer to some bytes, and a
length. You can look at these with the `as_ptr` and `len` methods:

```rust
use std::slice;
use std::str;

let story = "Once upon a time...";

let ptr = story.as_ptr();
let len = story.len();

// story has nineteen bytes
assert_eq!(19, len);

// We can re-build a str out of ptr and len. This is all unsafe because
// we are responsible for making sure the two components are valid:
let s = unsafe {
    // First, we build a &[u8]...
    let slice = slice::from_raw_parts(ptr, len);

    // ... and then convert that slice into a string slice
    str::from_utf8(slice)
};

assert_eq!(s, Ok(story));
```

Note: This example shows the internals of `&str`. `unsafe` should not be
used to get a string slice under normal circumstances. Use `as_str`
instead.

## Invariant

Rust libraries may assume that string slices are always valid UTF-8.

Constructing a non-UTF-8 string slice is not immediate undefined behavior, but any function
called on a string slice may assume that it is valid UTF-8, which means that a non-UTF-8 string
slice can lead to undefined behavior down the road.


# Table of Contents

## Sections

- [Basic Usage](#basic-usage)
- [Representation](#representation)
- [Invariant](#invariant)

## Associated Functions

- [from_utf8](#method.from_utf8)
- [from_utf8_mut](#method.from_utf8_mut)
- [from_utf8_unchecked](#method.from_utf8_unchecked)
- [from_utf8_unchecked_mut](#method.from_utf8_unchecked_mut)

## Methods

- [as_ascii](#method.as_ascii)
- [as_ascii_unchecked](#method.as_ascii_unchecked)
- [as_bytes](#method.as_bytes)
- [as_bytes_mut](#method.as_bytes_mut)
- [as_mut_ptr](#method.as_mut_ptr)
- [as_ptr](#method.as_ptr)
- [as_str](#method.as_str)
- [bytes](#method.bytes)
- [ceil_char_boundary](#method.ceil_char_boundary)
- [char_indices](#method.char_indices)
- [chars](#method.chars)
- [contains](#method.contains)
- [copy_from_str](#method.copy_from_str)
- [encode_utf16](#method.encode_utf16)
- [ends_with](#method.ends_with)
- [eq_ignore_ascii_case](#method.eq_ignore_ascii_case)
- [eq_ignore_case_unnormalized](#method.eq_ignore_case_unnormalized)
- [escape_debug](#method.escape_debug)
- [escape_default](#method.escape_default)
- [escape_unicode](#method.escape_unicode)
- [find](#method.find)
- [floor_char_boundary](#method.floor_char_boundary)
- [get](#method.get)
- [get_mut](#method.get_mut)
- [get_unchecked](#method.get_unchecked)
- [get_unchecked_mut](#method.get_unchecked_mut)
- [is_ascii](#method.is_ascii)
- [is_char_boundary](#method.is_char_boundary)
- [is_empty](#method.is_empty)
- [len](#method.len)
- [lines](#method.lines)
- [lines_any](#method.lines_any)
- [make_ascii_lowercase](#method.make_ascii_lowercase)
- [make_ascii_uppercase](#method.make_ascii_uppercase)
- [match_indices](#method.match_indices)
- [matches](#method.matches)
- [parse](#method.parse)
- [rfind](#method.rfind)
- [rmatch_indices](#method.rmatch_indices)
- [rmatches](#method.rmatches)
- [rsplit](#method.rsplit)
- [rsplit_once](#method.rsplit_once)
- [rsplit_terminator](#method.rsplit_terminator)
- [rsplitn](#method.rsplitn)
- [slice_mut_unchecked](#method.slice_mut_unchecked)
- [slice_unchecked](#method.slice_unchecked)
- [split](#method.split)
- [split_ascii_whitespace](#method.split_ascii_whitespace)
- [split_at](#method.split_at)
- [split_at_checked](#method.split_at_checked)
- [split_at_mut](#method.split_at_mut)
- [split_at_mut_checked](#method.split_at_mut_checked)
- [split_inclusive](#method.split_inclusive)
- [split_once](#method.split_once)
- [split_terminator](#method.split_terminator)
- [split_whitespace](#method.split_whitespace)
- [splitn](#method.splitn)
- [starts_with](#method.starts_with)
- [strip_circumfix](#method.strip_circumfix)
- [strip_prefix](#method.strip_prefix)
- [strip_suffix](#method.strip_suffix)
- [substr_range](#method.substr_range)
- [trim](#method.trim)
- [trim_ascii](#method.trim_ascii)
- [trim_ascii_end](#method.trim_ascii_end)
- [trim_ascii_start](#method.trim_ascii_start)
- [trim_end](#method.trim_end)
- [trim_end_matches](#method.trim_end_matches)
- [trim_left](#method.trim_left)
- [trim_left_matches](#method.trim_left_matches)
- [trim_matches](#method.trim_matches)
- [trim_prefix](#method.trim_prefix)
- [trim_right](#method.trim_right)
- [trim_right_matches](#method.trim_right_matches)
- [trim_start](#method.trim_start)
- [trim_start_matches](#method.trim_start_matches)
- [trim_suffix](#method.trim_suffix)

## Trait Implementations

- [!Error](#impl-Error-for-%26str)
- [AsMut<str>](#impl-AsMut%3Cstr%3E-for-str)
- [AsRef<ByteStr>](#impl-AsRef%3CByteStr%3E-for-str)
- [AsRef<[u8]>](#impl-AsRef%3C%5Bu8%5D%3E-for-str)
- [AsRef<str>](#impl-AsRef%3Cstr%3E-for-str)
- [CloneToUninit](#impl-CloneToUninit-for-str)
- [ConstParamTy_](#impl-ConstParamTy_-for-str)
- [Debug](#impl-Debug-for-str)
- [Default](#impl-Default-for-%26mut+str)
- [Default](#impl-Default-for-%26str)
- [Display](#impl-Display-for-str)
- [Eq](#impl-Eq-for-str)
- [Hash](#impl-Hash-for-str)
- [Index<I>](#impl-Index%3CI%3E-for-str)
- [IndexMut<I>](#impl-IndexMut%3CI%3E-for-str)
- [Ord](#impl-Ord-for-str)
- [PartialEq](#impl-PartialEq-for-str)
- [PartialEq<&#38;str>](#impl-PartialEq%3C%26str%3E-for-ByteStr)
- [PartialEq<ByteStr>](#impl-PartialEq%3CByteStr%3E-for-%26str)
- [PartialEq<ByteStr>](#impl-PartialEq%3CByteStr%3E-for-str)
- [PartialEq<str>](#impl-PartialEq%3Cstr%3E-for-ByteStr)
- [PartialOrd](#impl-PartialOrd-for-str)
- [Pattern](#impl-Pattern-for-%26str)
- [SliceIndex<str>](#impl-SliceIndex%3Cstr%3E-for-(Bound%3Cusize%3E,+Bound%3Cusize%3E))
- [SliceIndex<str>](#impl-SliceIndex%3Cstr%3E-for-Range%3Cusize%3E)
- [SliceIndex<str>](#impl-SliceIndex%3Cstr%3E-for-Range%3Cusize%3E-1)
- [SliceIndex<str>](#impl-SliceIndex%3Cstr%3E-for-RangeFrom%3Cusize%3E)
- [SliceIndex<str>](#impl-SliceIndex%3Cstr%3E-for-RangeFrom%3Cusize%3E-1)
- [SliceIndex<str>](#impl-SliceIndex%3Cstr%3E-for-RangeFull)
- [SliceIndex<str>](#impl-SliceIndex%3Cstr%3E-for-RangeInclusive%3Cusize%3E)
- [SliceIndex<str>](#impl-SliceIndex%3Cstr%3E-for-RangeInclusive%3Cusize%3E-1)
- [SliceIndex<str>](#impl-SliceIndex%3Cstr%3E-for-RangeTo%3Cusize%3E)
- [SliceIndex<str>](#impl-SliceIndex%3Cstr%3E-for-RangeToInclusive%3Cusize%3E)
- [SliceIndex<str>](#impl-SliceIndex%3Cstr%3E-for-RangeToInclusive%3Cusize%3E-1)
- [StructuralPartialEq](#impl-StructuralPartialEq-for-str)
- [TryFrom<&#38;'a ByteStr>](#impl-TryFrom%3C%26ByteStr%3E-for-%26str)
- [TryFrom<&#38;'a mut ByteStr>](#impl-TryFrom%3C%26mut+ByteStr%3E-for-%26mut+str)

## Auto Trait Implementations

- [!Sized](#impl-Sized-for-str)
- [Freeze](#impl-Freeze-for-str)
- [RefUnwindSafe](#impl-RefUnwindSafe-for-str)
- [Send](#impl-Send-for-str)
- [Sync](#impl-Sync-for-str)
- [Unpin](#impl-Unpin-for-str)
- [UnsafeUnpin](#impl-UnsafeUnpin-for-str)
- [UnwindSafe](#impl-UnwindSafe-for-str)

## Blanket Implementations

- [Any](#impl-Any-for-T)
- [Borrow<T>](#impl-Borrow%3CT%3E-for-T)
- [BorrowMut<T>](#impl-BorrowMut%3CT%3E-for-T)


# Implementations

## impl str

```rust
pub const fn len(&self) -> usize
```
Returns the length of `self`.

This length is in bytes, not `char`s or graphemes. In other words,
it might not be what a human considers the length of the string.

Examples

```rust
let len = "foo".len();
assert_eq!(3, len);

assert_eq!("ƒoo".len(), 4); // fancy f!
assert_eq!("ƒoo".chars().count(), 3);
```

```rust
pub const fn is_empty(&self) -> bool
```
Returns `true` if `self` has a length of zero bytes.

Examples

```rust
let s = "";
assert!(s.is_empty());

let s = "not empty";
assert!(!s.is_empty());
```

```rust
pub const fn from_utf8(v: &[u8]) -> Result<&str, Utf8Error>
```
Converts a slice of bytes to a string slice.

A string slice (`&str`) is made of bytes (`u8`), and a byte slice
(`&[u8]`) is made of bytes, so this function converts between
the two. Not all byte slices are valid string slices, however: `&str` requires
that it is valid UTF-8. `from_utf8()` checks to ensure that the bytes are valid
UTF-8, and then does the conversion.

If you are sure that the byte slice is valid UTF-8, and you don’t want to
incur the overhead of the validity check, there is an unsafe version of
this function, `from_utf8_unchecked`, which has the same
behavior but skips the check.

If you need a `String` instead of a `&str`, consider
`String::from_utf8`.

Because you can stack-allocate a `[u8; N]`, and you can take a
`&[u8]` of it, this function is one way to have a
stack-allocated string. There is an example of this in the
examples section below.

Errors
Returns `Err` if the slice is not UTF-8 with a description as to why the
provided slice is not UTF-8.

Examples
Basic usage:

```rust
// some bytes, in a vector
let sparkle_heart = vec![240, 159, 146, 150];

// We can use the ? (try) operator to check if the bytes are valid
let sparkle_heart = str::from_utf8(&sparkle_heart)?;

assert_eq!("💖", sparkle_heart);
```

Incorrect bytes:

```rust
// some invalid bytes, in a vector
let sparkle_heart = vec![0, 159, 146, 150];

assert!(str::from_utf8(&sparkle_heart).is_err());
```

See the docs for `Utf8Error` for more details on the kinds of
errors that can be returned.

A “stack allocated string”:

```rust
// some bytes, in a stack-allocated array
let sparkle_heart = [240, 159, 146, 150];

// We know these bytes are valid, so just use `unwrap()`.
let sparkle_heart: &str = str::from_utf8(&sparkle_heart).unwrap();

assert_eq!("💖", sparkle_heart);
```

```rust
pub const fn from_utf8_mut(v: &mut [u8]) -> Result<&mut str, Utf8Error>
```
Converts a mutable slice of bytes to a mutable string slice.

Examples
Basic usage:

```rust
// "Hello, Rust!" as a mutable vector
let mut hellorust = vec![72, 101, 108, 108, 111, 44, 32, 82, 117, 115, 116, 33];

// As we know these bytes are valid, we can use `unwrap()`
let outstr = str::from_utf8_mut(&mut hellorust).unwrap();

assert_eq!("Hello, Rust!", outstr);
```

Incorrect bytes:

```rust
// Some invalid bytes in a mutable vector
let mut invalid = vec![128, 223];

assert!(str::from_utf8_mut(&mut invalid).is_err());
```

See the docs for `Utf8Error` for more details on the kinds of
errors that can be returned.

```rust
pub const unsafe fn from_utf8_unchecked(v: &[u8]) -> &str
```
Converts a slice of bytes to a string slice without checking
that the string contains valid UTF-8.

See the safe version, `from_utf8`, for more information.

Safety
The bytes passed in must be valid UTF-8.

Examples
Basic usage:

```rust
// some bytes, in a vector
let sparkle_heart = vec![240, 159, 146, 150];

let sparkle_heart = unsafe {
    str::from_utf8_unchecked(&sparkle_heart)
};

assert_eq!("💖", sparkle_heart);
```

```rust
pub const unsafe fn from_utf8_unchecked_mut(v: &mut [u8]) -> &mut str
```
Converts a slice of bytes to a string slice without checking
that the string contains valid UTF-8; mutable version.

See the immutable version, `from_utf8_unchecked()` for documentation and safety requirements.

Examples
Basic usage:

```rust
let mut heart = vec![240, 159, 146, 150];
let heart = unsafe { str::from_utf8_unchecked_mut(&mut heart) };

assert_eq!("💖", heart);
```

```rust
pub const fn is_char_boundary(&self, index: usize) -> bool
```
Checks that `index`-th byte is the first byte in a UTF-8 code point
sequence or the end of the string.

The start and end of the string (when `index == self.len()`) are
considered to be boundaries.

Returns `false` if `index` is greater than `self.len()`.

Examples

```rust
let s = "Löwe 老虎 Léopard";
assert!(s.is_char_boundary(0));
// start of `老`
assert!(s.is_char_boundary(6));
assert!(s.is_char_boundary(s.len()));

// second byte of `ö`
assert!(!s.is_char_boundary(2));

// third byte of `老`
assert!(!s.is_char_boundary(8));
```

```rust
pub const fn floor_char_boundary(&self, index: usize) -> usize
```
Finds the closest `x` not exceeding `index` where `is_char_boundary(x)` is `true`.

This method can help you truncate a string so that it’s still valid UTF-8, but doesn’t
exceed a given number of bytes. Note that this is done purely at the character level
and can still visually split graphemes, even though the underlying characters aren’t
split. For example, the emoji 🧑‍🔬 (scientist) could be split so that the string only
includes 🧑 (person) instead.

Examples

```rust
let s = "❤️🧡💛💚💙💜";
assert_eq!(s.len(), 26);
assert!(!s.is_char_boundary(13));

let closest = s.floor_char_boundary(13);
assert_eq!(closest, 10);
assert_eq!(&s[..closest], "❤️🧡");
```

```rust
pub const fn ceil_char_boundary(&self, index: usize) -> usize
```
Finds the closest `x` not below `index` where `is_char_boundary(x)` is `true`.

If `index` is greater than the length of the string, this returns the length of the string.

This method is the natural complement to `floor_char_boundary`. See that method
for more details.

Examples

```rust
let s = "❤️🧡💛💚💙💜";
assert_eq!(s.len(), 26);
assert!(!s.is_char_boundary(13));

let closest = s.ceil_char_boundary(13);
assert_eq!(closest, 14);
assert_eq!(&s[..closest], "❤️🧡💛");
```

```rust
pub const fn as_bytes(&self) -> &[u8]
```
Converts a string slice to a byte slice. To convert the byte slice back
into a string slice, use the `from_utf8` function.

Examples

```rust
let bytes = "bors".as_bytes();
assert_eq!(b"bors", bytes);
```

```rust
pub const unsafe fn as_bytes_mut(&mut self) -> &mut [u8]
```
Converts a mutable string slice to a mutable byte slice.

Safety
The caller must ensure that the content of the slice is valid UTF-8
before the borrow ends and the underlying `str` is used.

Use of a `str` whose contents are not valid UTF-8 is undefined behavior.

Examples
Basic usage:

```rust
let mut s = String::from("Hello");
let bytes = unsafe { s.as_bytes_mut() };

assert_eq!(b"Hello", bytes);
```

Mutability:

```rust
let mut s = String::from("🗻∈🌏");

unsafe {
    let bytes = s.as_bytes_mut();

    bytes[0] = 0xF0;
    bytes[1] = 0x9F;
    bytes[2] = 0x8D;
    bytes[3] = 0x94;
}

assert_eq!("🍔∈🌏", s);
```

```rust
pub const fn as_ptr(&self) -> *const u8
```
Converts a string slice to a raw pointer.

As string slices are a slice of bytes, the raw pointer points to a
`u8`. This pointer will be pointing to the first byte of the string
slice.

The caller must ensure that the returned pointer is never written to.
If you need to mutate the contents of the string slice, use `as_mut_ptr`.

Examples

```rust
let s = "Hello";
let ptr = s.as_ptr();
```

```rust
pub const fn as_mut_ptr(&mut self) -> *mut u8
```
Converts a mutable string slice to a raw pointer.

As string slices are a slice of bytes, the raw pointer points to a
`u8`. This pointer will be pointing to the first byte of the string
slice.

It is your responsibility to make sure that the string slice only gets
modified in a way that it remains valid UTF-8.

```rust
pub fn get<I: SliceIndex<str>>(&self, i: I) -> Option<&I::Output>
```
Returns a subslice of `str`.

This is the non-panicking alternative to indexing the `str`. Returns
`None` whenever equivalent indexing operation would panic.

Examples

```rust
let v = String::from("🗻∈🌏");

assert_eq!(Some("🗻"), v.get(0..4));

// indices not on UTF-8 sequence boundaries
assert!(v.get(1..).is_none());
assert!(v.get(..8).is_none());

// out of bounds
assert!(v.get(..42).is_none());
```

```rust
pub fn get_mut<I: SliceIndex<str>>(&mut self, i: I) -> Option<&mut I::Output>
```
Returns a mutable subslice of `str`.

This is the non-panicking alternative to indexing the `str`. Returns
`None` whenever equivalent indexing operation would panic.

Examples

```rust
let mut v = String::from("hello");
// correct length
assert!(v.get_mut(0..5).is_some());
// out of bounds
assert!(v.get_mut(..42).is_none());
assert_eq!(Some("he"), v.get_mut(0..2).map(|v| &*v));

assert_eq!("hello", v);
{
    let s = v.get_mut(0..2);
    let s = s.map(|s| {
        s.make_ascii_uppercase();
        &*s
    });
    assert_eq!(Some("HE"), s);
}
assert_eq!("HEllo", v);
```

```rust
pub unsafe fn get_unchecked<I: SliceIndex<str>>(&self, i: I) -> &I::Output
```
Returns an unchecked subslice of `str`.

This is the unchecked alternative to indexing the `str`.

Safety
Callers of this function are responsible that these preconditions are
satisfied:

  - The starting index must not exceed the ending index;

  - Indexes must be within bounds of the original slice;

  - Indexes must lie on UTF-8 sequence boundaries.

Failing that, the returned string slice may reference invalid memory or
violate the invariants communicated by the `str` type.

Examples

```rust
let v = "🗻∈🌏";
unsafe {
    assert_eq!("🗻", v.get_unchecked(0..4));
    assert_eq!("∈", v.get_unchecked(4..7));
    assert_eq!("🌏", v.get_unchecked(7..11));
}
```

```rust
pub unsafe fn get_unchecked_mut<I: SliceIndex<str>>(
    &mut self,
    i: I,
) -> &mut I::Output
```
Returns a mutable, unchecked subslice of `str`.

This is the unchecked alternative to indexing the `str`.

Safety
Callers of this function are responsible that these preconditions are
satisfied:

  - The starting index must not exceed the ending index;

  - Indexes must be within bounds of the original slice;

  - Indexes must lie on UTF-8 sequence boundaries.

Failing that, the returned string slice may reference invalid memory or
violate the invariants communicated by the `str` type.

Examples

```rust
let mut v = String::from("🗻∈🌏");
unsafe {
    assert_eq!("🗻", v.get_unchecked_mut(0..4));
    assert_eq!("∈", v.get_unchecked_mut(4..7));
    assert_eq!("🌏", v.get_unchecked_mut(7..11));
}
```

```rust
pub unsafe fn slice_unchecked(&self, begin: usize, end: usize) -> &str
```
Creates a string slice from another string slice, bypassing safety
checks.

This is generally not recommended, use with caution! For a safe
alternative see `str` and `Index`.

This new slice goes from `begin` to `end`, including `begin` but
excluding `end`.

To get a mutable string slice instead, see the
`slice_mut_unchecked` method.

Safety
Callers of this function are responsible that three preconditions are
satisfied:

  - `begin` must not exceed `end`.

  - `begin` and `end` must be byte positions within the string slice.

  - `begin` and `end` must lie on UTF-8 sequence boundaries.

Examples

```rust
let s = "Löwe 老虎 Léopard";

unsafe {
    assert_eq!("Löwe 老虎 Léopard", s.slice_unchecked(0, 21));
}

let s = "Hello, world!";

unsafe {
    assert_eq!("world", s.slice_unchecked(7, 12));
}
```

```rust
pub unsafe fn slice_mut_unchecked(
    &mut self,
    begin: usize,
    end: usize,
) -> &mut str
```
Creates a string slice from another string slice, bypassing safety
checks.

This is generally not recommended, use with caution! For a safe
alternative see `str` and `IndexMut`.

This new slice goes from `begin` to `end`, including `begin` but
excluding `end`.

To get an immutable string slice instead, see the
`slice_unchecked` method.

Safety
Callers of this function are responsible that three preconditions are
satisfied:

  - `begin` must not exceed `end`.

  - `begin` and `end` must be byte positions within the string slice.

  - `begin` and `end` must lie on UTF-8 sequence boundaries.

```rust
pub const fn split_at(&self, mid: usize) -> (&str, &str)
```
Divides one string slice into two at an index.

The argument, `mid`, should be a byte offset from the start of the
string. It must also be on the boundary of a UTF-8 code point.

The two slices returned go from the start of the string slice to `mid`,
and from `mid` to the end of the string slice.

To get mutable string slices instead, see the `split_at_mut`
method.

Panics
Panics if `mid` is not on a UTF-8 code point boundary, or if it is past
the end of the last code point of the string slice.  For a non-panicking
alternative see `split_at_checked`.

Examples

```rust
let s = "Per Martin-Löf";

let (first, last) = s.split_at(3);

assert_eq!("Per", first);
assert_eq!(" Martin-Löf", last);
```

```rust
pub const fn split_at_mut(&mut self, mid: usize) -> (&mut str, &mut str)
```
Divides one mutable string slice into two at an index.

The argument, `mid`, should be a byte offset from the start of the
string. It must also be on the boundary of a UTF-8 code point.

The two slices returned go from the start of the string slice to `mid`,
and from `mid` to the end of the string slice.

To get immutable string slices instead, see the `split_at` method.

Panics
Panics if `mid` is not on a UTF-8 code point boundary, or if it is past
the end of the last code point of the string slice.  For a non-panicking
alternative see `split_at_mut_checked`.

Examples

```rust
let mut s = "Per Martin-Löf".to_string();
{
    let (first, last) = s.split_at_mut(3);
    first.make_ascii_uppercase();
    assert_eq!("PER", first);
    assert_eq!(" Martin-Löf", last);
}
assert_eq!("PER Martin-Löf", s);
```

```rust
pub const fn split_at_checked(&self, mid: usize) -> Option<(&str, &str)>
```
Divides one string slice into two at an index.

The argument, `mid`, should be a valid byte offset from the start of the
string. It must also be on the boundary of a UTF-8 code point. The
method returns `None` if that’s not the case.

The two slices returned go from the start of the string slice to `mid`,
and from `mid` to the end of the string slice.

To get mutable string slices instead, see the `split_at_mut_checked`
method.

Examples

```rust
let s = "Per Martin-Löf";

let (first, last) = s.split_at_checked(3).unwrap();
assert_eq!("Per", first);
assert_eq!(" Martin-Löf", last);

assert_eq!(None, s.split_at_checked(13));  // Inside “ö”
assert_eq!(None, s.split_at_checked(16));  // Beyond the string length
```

```rust
pub const fn split_at_mut_checked(
    &mut self,
    mid: usize,
) -> Option<(&mut str, &mut str)>
```
Divides one mutable string slice into two at an index.

The argument, `mid`, should be a valid byte offset from the start of the
string. It must also be on the boundary of a UTF-8 code point. The
method returns `None` if that’s not the case.

The two slices returned go from the start of the string slice to `mid`,
and from `mid` to the end of the string slice.

To get immutable string slices instead, see the `split_at_checked` method.

Examples

```rust
let mut s = "Per Martin-Löf".to_string();
if let Some((first, last)) = s.split_at_mut_checked(3) {
    first.make_ascii_uppercase();
    assert_eq!("PER", first);
    assert_eq!(" Martin-Löf", last);
}
assert_eq!("PER Martin-Löf", s);

assert_eq!(None, s.split_at_mut_checked(13));  // Inside “ö”
assert_eq!(None, s.split_at_mut_checked(16));  // Beyond the string length
```

```rust
pub fn chars(&self) -> Chars<'_>
```
Returns an iterator over the `char`s of a string slice.

As a string slice consists of valid UTF-8, we can iterate through a
string slice by `char`. This method returns such an iterator.

It’s important to remember that `char` represents a Unicode Scalar
Value, and might not match your idea of what a ‘character’ is. Iteration
over grapheme clusters may be what you actually want. This functionality
is not provided by Rust’s standard library, check crates.io instead.

Examples
Basic usage:

```rust
let word = "goodbye";

let count = word.chars().count();
assert_eq!(7, count);

let mut chars = word.chars();

assert_eq!(Some('g'), chars.next());
assert_eq!(Some('o'), chars.next());
assert_eq!(Some('o'), chars.next());
assert_eq!(Some('d'), chars.next());
assert_eq!(Some('b'), chars.next());
assert_eq!(Some('y'), chars.next());
assert_eq!(Some('e'), chars.next());

assert_eq!(None, chars.next());
```

Remember, `char`s might not match your intuition about characters:

```rust
let y = "y̆";

let mut chars = y.chars();

assert_eq!(Some('y'), chars.next()); // not 'y̆'
assert_eq!(Some('\u{0306}'), chars.next());

assert_eq!(None, chars.next());
```

```rust
pub fn char_indices(&self) -> CharIndices<'_>
```
Returns an iterator over the `char`s of a string slice, and their
positions.

As a string slice consists of valid UTF-8, we can iterate through a
string slice by `char`. This method returns an iterator of both
these `char`s, as well as their byte positions.

The iterator yields tuples. The position is first, the `char` is
second.

Examples
Basic usage:

```rust
let word = "goodbye";

let count = word.char_indices().count();
assert_eq!(7, count);

let mut char_indices = word.char_indices();

assert_eq!(Some((0, 'g')), char_indices.next());
assert_eq!(Some((1, 'o')), char_indices.next());
assert_eq!(Some((2, 'o')), char_indices.next());
assert_eq!(Some((3, 'd')), char_indices.next());
assert_eq!(Some((4, 'b')), char_indices.next());
assert_eq!(Some((5, 'y')), char_indices.next());
assert_eq!(Some((6, 'e')), char_indices.next());

assert_eq!(None, char_indices.next());
```

Remember, `char`s might not match your intuition about characters:

```rust
let yes = "y̆es";

let mut char_indices = yes.char_indices();

assert_eq!(Some((0, 'y')), char_indices.next()); // not (0, 'y̆')
assert_eq!(Some((1, '\u{0306}')), char_indices.next());

// note the 3 here - the previous character took up two bytes
assert_eq!(Some((3, 'e')), char_indices.next());
assert_eq!(Some((4, 's')), char_indices.next());

assert_eq!(None, char_indices.next());
```

```rust
pub fn bytes(&self) -> Bytes<'_>
```
Returns an iterator over the bytes of a string slice.

As a string slice consists of a sequence of bytes, we can iterate
through a string slice by byte. This method returns such an iterator.

Examples

```rust
let mut bytes = "bors".bytes();

assert_eq!(Some(b'b'), bytes.next());
assert_eq!(Some(b'o'), bytes.next());
assert_eq!(Some(b'r'), bytes.next());
assert_eq!(Some(b's'), bytes.next());

assert_eq!(None, bytes.next());
```

```rust
pub fn split_whitespace(&self) -> SplitWhitespace<'_>
```
Splits a string slice by whitespace.

The iterator returned will return string slices that are sub-slices of
the original string slice, separated by any amount of whitespace.

‘Whitespace’ is defined according to the terms of the Unicode Derived
Core Property `White_Space`. If you only want to split on ASCII whitespace
instead, use `split_ascii_whitespace`.

Examples
Basic usage:

```rust
let mut iter = "A few words".split_whitespace();

assert_eq!(Some("A"), iter.next());
assert_eq!(Some("few"), iter.next());
assert_eq!(Some("words"), iter.next());

assert_eq!(None, iter.next());
```

All kinds of whitespace are considered:

```rust
let mut iter = " Mary   had\ta\u{2009}little  \n\t lamb".split_whitespace();
assert_eq!(Some("Mary"), iter.next());
assert_eq!(Some("had"), iter.next());
assert_eq!(Some("a"), iter.next());
assert_eq!(Some("little"), iter.next());
assert_eq!(Some("lamb"), iter.next());

assert_eq!(None, iter.next());
```

If the string is empty or all whitespace, the iterator yields no string slices:

```rust
assert_eq!("".split_whitespace().next(), None);
assert_eq!("   ".split_whitespace().next(), None);
```

```rust
pub fn split_ascii_whitespace(&self) -> SplitAsciiWhitespace<'_>
```
Splits a string slice by ASCII whitespace.

The iterator returned will return string slices that are sub-slices of
the original string slice, separated by any amount of ASCII whitespace.

This uses the same definition as `char::is_ascii_whitespace`.
To split by Unicode `Whitespace` instead, use `split_whitespace`.
Note that because of this difference in definition, even if `s.is_ascii()`
is `true`, `s.split_ascii_whitespace()` behavior will differ from `s.split_whitespace()`
if `s` contains U+000B VERTICAL TAB.

Examples
Basic usage:

```rust
let mut iter = "A few words".split_ascii_whitespace();

assert_eq!(Some("A"), iter.next());
assert_eq!(Some("few"), iter.next());
assert_eq!(Some("words"), iter.next());

assert_eq!(None, iter.next());
```

Various kinds of ASCII whitespace are considered
(see `char::is_ascii_whitespace`):

```rust
let mut iter = " Mary   had\ta little  \n\t lamb".split_ascii_whitespace();
assert_eq!(Some("Mary"), iter.next());
assert_eq!(Some("had"), iter.next());
assert_eq!(Some("a"), iter.next());
assert_eq!(Some("little"), iter.next());
assert_eq!(Some("lamb"), iter.next());

assert_eq!(None, iter.next());
```

If the string is empty or all ASCII whitespace, the iterator yields no string slices:

```rust
assert_eq!("".split_ascii_whitespace().next(), None);
assert_eq!("   ".split_ascii_whitespace().next(), None);
```

```rust
pub fn lines(&self) -> Lines<'_>
```
Returns an iterator over the lines of a string, as string slices.

Lines are split at line endings that are either newlines (`\n`) or
sequences of a carriage return followed by a line feed (`\r\n`).

Line terminators are not included in the lines returned by the iterator.

Note that any carriage return (`\r`) not immediately followed by a
line feed (`\n`) does not split a line. These carriage returns are
thereby included in the produced lines.

The final line ending is optional. A string that ends with a final line
ending will return the same lines as an otherwise identical string
without a final line ending.

An empty string returns an empty iterator.

Examples
Basic usage:

```rust
let text = "foo\r\nbar\n\nbaz\r";
let mut lines = text.lines();

assert_eq!(Some("foo"), lines.next());
assert_eq!(Some("bar"), lines.next());
assert_eq!(Some(""), lines.next());
// Trailing carriage return is included in the last line
assert_eq!(Some("baz\r"), lines.next());

assert_eq!(None, lines.next());
```

The final line does not require any ending:

```rust
let text = "foo\nbar\n\r\nbaz";
let mut lines = text.lines();

assert_eq!(Some("foo"), lines.next());
assert_eq!(Some("bar"), lines.next());
assert_eq!(Some(""), lines.next());
assert_eq!(Some("baz"), lines.next());

assert_eq!(None, lines.next());
```

An empty string returns an empty iterator:

```rust
let text = "";
let mut lines = text.lines();

assert_eq!(lines.next(), None);
```

```rust
pub fn lines_any(&self) -> LinesAny<'_>
```
Returns an iterator over the lines of a string.

```rust
pub fn encode_utf16(&self) -> EncodeUtf16<'_>
```
Returns an iterator of `u16` over the string encoded
as native endian UTF-16 (without byte-order mark).

Examples

```rust
let text = "Zażółć gęślą jaźń";

let utf8_len = text.len();
let utf16_len = text.encode_utf16().count();

assert!(utf16_len <= utf8_len);
```

```rust
pub fn contains<P: Pattern>(&self, pat: P) -> bool
```
Returns `true` if the given pattern matches a sub-slice of
this string slice.

Returns `false` if it does not.

The pattern can be a `&str`, `char`, a slice of `char`s, or a
function or closure that determines if a character matches.

Examples

```rust
let bananas = "bananas";

assert!(bananas.contains("nana"));
assert!(!bananas.contains("apples"));
```

```rust
pub fn starts_with<P: Pattern>(&self, pat: P) -> bool
```
Returns `true` if the given pattern matches a prefix of this
string slice.

Returns `false` if it does not.

The pattern can be a `&str`, in which case this function will return true if
the `&str` is a prefix of this string slice.

The pattern can also be a `char`, a slice of `char`s, or a
function or closure that determines if a character matches.
These will only be checked against the first character of this string slice.
Look at the second example below regarding behavior for slices of `char`s.

Examples

```rust
let bananas = "bananas";

assert!(bananas.starts_with("bana"));
assert!(!bananas.starts_with("nana"));
```

```rust
let bananas = "bananas";

// Note that both of these assert successfully.
assert!(bananas.starts_with(&['b', 'a', 'n', 'a']));
assert!(bananas.starts_with(&['a', 'b', 'c', 'd']));
```

```rust
pub fn ends_with<P: Pattern>(&self, pat: P) -> bool
where
    for<'a> P::Searcher<'a>: ReverseSearcher<'a>,
```
Returns `true` if the given pattern matches a suffix of this
string slice.

Returns `false` if it does not.

The pattern can be a `&str`, `char`, a slice of `char`s, or a
function or closure that determines if a character matches.

Examples

```rust
let bananas = "bananas";

assert!(bananas.ends_with("anas"));
assert!(!bananas.ends_with("nana"));
```

```rust
pub fn find<P: Pattern>(&self, pat: P) -> Option<usize>
```
Returns the byte index of the first character of this string slice that
matches the pattern.

Returns `None` if the pattern doesn’t match.

The pattern can be a `&str`, `char`, a slice of `char`s, or a
function or closure that determines if a character matches.

Examples
Simple patterns:

```rust
let s = "Löwe 老虎 Léopard Gepardi";

assert_eq!(s.find('L'), Some(0));
assert_eq!(s.find('é'), Some(14));
assert_eq!(s.find("pard"), Some(17));
```

More complex patterns using point-free style and closures:

```rust
let s = "Löwe 老虎 Léopard";

assert_eq!(s.find(char::is_whitespace), Some(5));
assert_eq!(s.find(char::is_lowercase), Some(1));
assert_eq!(s.find(|c: char| c.is_whitespace() || c.is_lowercase()), Some(1));
assert_eq!(s.find(|c: char| (c < 'o') && (c > 'a')), Some(4));
```

Not finding the pattern:

```rust
let s = "Löwe 老虎 Léopard";
let x: &[_] = &['1', '2'];

assert_eq!(s.find(x), None);
```

```rust
pub fn rfind<P: Pattern>(&self, pat: P) -> Option<usize>
where
    for<'a> P::Searcher<'a>: ReverseSearcher<'a>,
```
Returns the byte index for the first character of the last match of the pattern in
this string slice.

Returns `None` if the pattern doesn’t match.

The pattern can be a `&str`, `char`, a slice of `char`s, or a
function or closure that determines if a character matches.

Examples
Simple patterns:

```rust
let s = "Löwe 老虎 Léopard Gepardi";

assert_eq!(s.rfind('L'), Some(13));
assert_eq!(s.rfind('é'), Some(14));
assert_eq!(s.rfind("pard"), Some(24));
```

More complex patterns with closures:

```rust
let s = "Löwe 老虎 Léopard";

assert_eq!(s.rfind(char::is_whitespace), Some(12));
assert_eq!(s.rfind(char::is_lowercase), Some(20));
```

Not finding the pattern:

```rust
let s = "Löwe 老虎 Léopard";
let x: &[_] = &['1', '2'];

assert_eq!(s.rfind(x), None);
```

```rust
pub fn split<P: Pattern>(&self, pat: P) -> Split<'_, P>
```
Returns an iterator over substrings of this string slice, separated by
characters matched by a pattern.

The pattern can be a `&str`, `char`, a slice of `char`s, or a
function or closure that determines if a character matches.

If there are no matches the full string slice is returned as the only
item in the iterator.

Iterator behavior
The returned iterator will be a `DoubleEndedIterator` if the pattern
allows a reverse search and forward/reverse search yields the same
elements. This is true for, e.g., `char`, but not for `&str`.

If the pattern allows a reverse search but its results might differ
from a forward search, the `rsplit` method can be used.

Examples
Simple patterns:

```rust
let v: Vec<&str> = "Mary had a little lamb".split(' ').collect();
assert_eq!(v, ["Mary", "had", "a", "little", "lamb"]);

let v: Vec<&str> = "".split('X').collect();
assert_eq!(v, [""]);

let v: Vec<&str> = "lionXXtigerXleopard".split('X').collect();
assert_eq!(v, ["lion", "", "tiger", "leopard"]);

let v: Vec<&str> = "lion::tiger::leopard".split("::").collect();
assert_eq!(v, ["lion", "tiger", "leopard"]);

let v: Vec<&str> = "AABBCC".split("DD").collect();
assert_eq!(v, ["AABBCC"]);

let v: Vec<&str> = "abc1def2ghi".split(char::is_numeric).collect();
assert_eq!(v, ["abc", "def", "ghi"]);

let v: Vec<&str> = "lionXtigerXleopard".split(char::is_uppercase).collect();
assert_eq!(v, ["lion", "tiger", "leopard"]);
```

If the pattern is a slice of chars, split on each occurrence of any of the characters:

```rust
let v: Vec<&str> = "2020-11-03 23:59".split(&['-', ' ', ':', '@'][..]).collect();
assert_eq!(v, ["2020", "11", "03", "23", "59"]);
```

A more complex pattern, using a closure:

```rust
let v: Vec<&str> = "abc1defXghi".split(|c| c == '1' || c == 'X').collect();
assert_eq!(v, ["abc", "def", "ghi"]);
```

If a string contains multiple contiguous separators, you will end up
with empty strings in the output:

```rust
let x = "||||a||b|c".to_string();
let d: Vec<_> = x.split('|').collect();

assert_eq!(d, &["", "", "", "", "a", "", "b", "c"]);
```

Contiguous separators are separated by the empty string.

```rust
let x = "(///)".to_string();
let d: Vec<_> = x.split('/').collect();

assert_eq!(d, &["(", "", "", ")"]);
```

Separators at the start or end of a string are neighbored
by empty strings.

```rust
let d: Vec<_> = "010".split("0").collect();
assert_eq!(d, &["", "1", ""]);
```

When the empty string is used as a separator, it separates
every character in the string, along with the beginning
and end of the string.

```rust
let f: Vec<_> = "rust".split("").collect();
assert_eq!(f, &["", "r", "u", "s", "t", ""]);
```

Contiguous separators can lead to possibly surprising behavior
when whitespace is used as the separator. This code is correct:

```rust
let x = "    a  b c".to_string();
let d: Vec<_> = x.split(' ').collect();

assert_eq!(d, &["", "", "", "", "a", "", "b", "c"]);
```

It does *not* give you:

ⓘ
```rust
assert_eq!(d, &["a", "b", "c"]);
```

Use `split_whitespace` for this behavior.

```rust
pub fn split_inclusive<P: Pattern>(&self, pat: P) -> SplitInclusive<'_, P>
```
Returns an iterator over substrings of this string slice, separated by
characters matched by a pattern.

Differs from the iterator produced by `split` in that `split_inclusive`
leaves the matched part as the terminator of the substring.

The pattern can be a `&str`, `char`, a slice of `char`s, or a
function or closure that determines if a character matches.

Examples

```rust
let v: Vec<&str> = "Mary had a little lamb\nlittle lamb\nlittle lamb."
    .split_inclusive('\n').collect();
assert_eq!(v, ["Mary had a little lamb\n", "little lamb\n", "little lamb."]);
```

If the last element of the string is matched,
that element will be considered the terminator of the preceding substring.
That substring will be the last item returned by the iterator.

```rust
let v: Vec<&str> = "Mary had a little lamb\nlittle lamb\nlittle lamb.\n"
    .split_inclusive('\n').collect();
assert_eq!(v, ["Mary had a little lamb\n", "little lamb\n", "little lamb.\n"]);
```

```rust
pub fn rsplit<P: Pattern>(&self, pat: P) -> RSplit<'_, P>
where
    for<'a> P::Searcher<'a>: ReverseSearcher<'a>,
```
Returns an iterator over substrings of the given string slice, separated
by characters matched by a pattern and yielded in reverse order.

The pattern can be a `&str`, `char`, a slice of `char`s, or a
function or closure that determines if a character matches.

Iterator behavior
The returned iterator requires that the pattern supports a reverse
search, and it will be a `DoubleEndedIterator` if a forward/reverse
search yields the same elements.

For iterating from the front, the `split` method can be used.

Examples
Simple patterns:

```rust
let v: Vec<&str> = "Mary had a little lamb".rsplit(' ').collect();
assert_eq!(v, ["lamb", "little", "a", "had", "Mary"]);

let v: Vec<&str> = "".rsplit('X').collect();
assert_eq!(v, [""]);

let v: Vec<&str> = "lionXXtigerXleopard".rsplit('X').collect();
assert_eq!(v, ["leopard", "tiger", "", "lion"]);

let v: Vec<&str> = "lion::tiger::leopard".rsplit("::").collect();
assert_eq!(v, ["leopard", "tiger", "lion"]);
```

A more complex pattern, using a closure:

```rust
let v: Vec<&str> = "abc1defXghi".rsplit(|c| c == '1' || c == 'X').collect();
assert_eq!(v, ["ghi", "def", "abc"]);
```

```rust
pub fn split_terminator<P: Pattern>(&self, pat: P) -> SplitTerminator<'_, P>
```
Returns an iterator over substrings of the given string slice, separated
by characters matched by a pattern.

The pattern can be a `&str`, `char`, a slice of `char`s, or a
function or closure that determines if a character matches.

Equivalent to `split`, except that the trailing substring
is skipped if empty.

This method can be used for string data that is *terminated*,
rather than *separated* by a pattern.

Iterator behavior
The returned iterator will be a `DoubleEndedIterator` if the pattern
allows a reverse search and forward/reverse search yields the same
elements. This is true for, e.g., `char`, but not for `&str`.

If the pattern allows a reverse search but its results might differ
from a forward search, the `rsplit_terminator` method can be used.

Examples

```rust
let v: Vec<&str> = "A.B.".split_terminator('.').collect();
assert_eq!(v, ["A", "B"]);

let v: Vec<&str> = "A..B..".split_terminator(".").collect();
assert_eq!(v, ["A", "", "B", ""]);

let v: Vec<&str> = "A.B:C.D".split_terminator(&['.', ':'][..]).collect();
assert_eq!(v, ["A", "B", "C", "D"]);
```

```rust
pub fn rsplit_terminator<P: Pattern>(&self, pat: P) -> RSplitTerminator<'_, P>
where
    for<'a> P::Searcher<'a>: ReverseSearcher<'a>,
```
Returns an iterator over substrings of `self`, separated by characters
matched by a pattern and yielded in reverse order.

The pattern can be a `&str`, `char`, a slice of `char`s, or a
function or closure that determines if a character matches.

Equivalent to `split`, except that the trailing substring is
skipped if empty.

This method can be used for string data that is *terminated*,
rather than *separated* by a pattern.

Iterator behavior
The returned iterator requires that the pattern supports a
reverse search, and it will be double ended if a forward/reverse
search yields the same elements.

For iterating from the front, the `split_terminator` method can be
used.

Examples

```rust
let v: Vec<&str> = "A.B.".rsplit_terminator('.').collect();
assert_eq!(v, ["B", "A"]);

let v: Vec<&str> = "A..B..".rsplit_terminator(".").collect();
assert_eq!(v, ["", "B", "", "A"]);

let v: Vec<&str> = "A.B:C.D".rsplit_terminator(&['.', ':'][..]).collect();
assert_eq!(v, ["D", "C", "B", "A"]);
```

```rust
pub fn splitn<P: Pattern>(&self, n: usize, pat: P) -> SplitN<'_, P>
```
Returns an iterator over substrings of the given string slice, separated
by a pattern, restricted to returning at most `n` items.

If `n` substrings are returned, the last substring (the `n`th substring)
will contain the remainder of the string.

The pattern can be a `&str`, `char`, a slice of `char`s, or a
function or closure that determines if a character matches.

Iterator behavior
The returned iterator will not be double ended, because it is
not efficient to support.

If the pattern allows a reverse search, the `rsplitn` method can be
used.

Examples
Simple patterns:

```rust
let v: Vec<&str> = "Mary had a little lambda".splitn(3, ' ').collect();
assert_eq!(v, ["Mary", "had", "a little lambda"]);

let v: Vec<&str> = "lionXXtigerXleopard".splitn(3, "X").collect();
assert_eq!(v, ["lion", "", "tigerXleopard"]);

let v: Vec<&str> = "abcXdef".splitn(1, 'X').collect();
assert_eq!(v, ["abcXdef"]);

let v: Vec<&str> = "".splitn(1, 'X').collect();
assert_eq!(v, [""]);
```

A more complex pattern, using a closure:

```rust
let v: Vec<&str> = "abc1defXghi".splitn(2, |c| c == '1' || c == 'X').collect();
assert_eq!(v, ["abc", "defXghi"]);
```

```rust
pub fn rsplitn<P: Pattern>(&self, n: usize, pat: P) -> RSplitN<'_, P>
where
    for<'a> P::Searcher<'a>: ReverseSearcher<'a>,
```
Returns an iterator over substrings of this string slice, separated by a
pattern, starting from the end of the string, restricted to returning at
most `n` items.

If `n` substrings are returned, the last substring (the `n`th substring)
will contain the remainder of the string.

The pattern can be a `&str`, `char`, a slice of `char`s, or a
function or closure that determines if a character matches.

Iterator behavior
The returned iterator will not be double ended, because it is not
efficient to support.

For splitting from the front, the `splitn` method can be used.

Examples
Simple patterns:

```rust
let v: Vec<&str> = "Mary had a little lamb".rsplitn(3, ' ').collect();
assert_eq!(v, ["lamb", "little", "Mary had a"]);

let v: Vec<&str> = "lionXXtigerXleopard".rsplitn(3, 'X').collect();
assert_eq!(v, ["leopard", "tiger", "lionX"]);

let v: Vec<&str> = "lion::tiger::leopard".rsplitn(2, "::").collect();
assert_eq!(v, ["leopard", "lion::tiger"]);
```

A more complex pattern, using a closure:

```rust
let v: Vec<&str> = "abc1defXghi".rsplitn(2, |c| c == '1' || c == 'X').collect();
assert_eq!(v, ["ghi", "abc1def"]);
```

```rust
pub fn split_once<P: Pattern>(&self, delimiter: P) -> Option<(&str, &str)>
```
Splits the string on the first occurrence of the specified delimiter and
returns prefix before delimiter and suffix after delimiter.

Examples

```rust
assert_eq!("cfg".split_once('='), None);
assert_eq!("cfg=".split_once('='), Some(("cfg", "")));
assert_eq!("cfg=foo".split_once('='), Some(("cfg", "foo")));
assert_eq!("cfg=foo=bar".split_once('='), Some(("cfg", "foo=bar")));
```

```rust
pub fn rsplit_once<P: Pattern>(&self, delimiter: P) -> Option<(&str, &str)>
where
    for<'a> P::Searcher<'a>: ReverseSearcher<'a>,
```
Splits the string on the last occurrence of the specified delimiter and
returns prefix before delimiter and suffix after delimiter.

Examples

```rust
assert_eq!("cfg".rsplit_once('='), None);
assert_eq!("cfg=".rsplit_once('='), Some(("cfg", "")));
assert_eq!("cfg=foo".rsplit_once('='), Some(("cfg", "foo")));
assert_eq!("cfg=foo=bar".rsplit_once('='), Some(("cfg=foo", "bar")));
```

```rust
pub fn matches<P: Pattern>(&self, pat: P) -> Matches<'_, P>
```
Returns an iterator over the disjoint matches of a pattern within the
given string slice.

The pattern can be a `&str`, `char`, a slice of `char`s, or a
function or closure that determines if a character matches.

Iterator behavior
The returned iterator will be a `DoubleEndedIterator` if the pattern
allows a reverse search and forward/reverse search yields the same
elements. This is true for, e.g., `char`, but not for `&str`.

If the pattern allows a reverse search but its results might differ
from a forward search, the `rmatches` method can be used.

Examples

```rust
let v: Vec<&str> = "abcXXXabcYYYabc".matches("abc").collect();
assert_eq!(v, ["abc", "abc", "abc"]);

let v: Vec<&str> = "1abc2abc3".matches(char::is_numeric).collect();
assert_eq!(v, ["1", "2", "3"]);
```

```rust
pub fn rmatches<P: Pattern>(&self, pat: P) -> RMatches<'_, P>
where
    for<'a> P::Searcher<'a>: ReverseSearcher<'a>,
```
Returns an iterator over the disjoint matches of a pattern within this
string slice, yielded in reverse order.

The pattern can be a `&str`, `char`, a slice of `char`s, or a
function or closure that determines if a character matches.

Iterator behavior
The returned iterator requires that the pattern supports a reverse
search, and it will be a `DoubleEndedIterator` if a forward/reverse
search yields the same elements.

For iterating from the front, the `matches` method can be used.

Examples

```rust
let v: Vec<&str> = "abcXXXabcYYYabc".rmatches("abc").collect();
assert_eq!(v, ["abc", "abc", "abc"]);

let v: Vec<&str> = "1abc2abc3".rmatches(char::is_numeric).collect();
assert_eq!(v, ["3", "2", "1"]);
```

```rust
pub fn match_indices<P: Pattern>(&self, pat: P) -> MatchIndices<'_, P>
```
Returns an iterator over the disjoint matches of a pattern within this string
slice as well as the index that the match starts at.

For matches of `pat` within `self` that overlap, only the indices
corresponding to the first match are returned.

The pattern can be a `&str`, `char`, a slice of `char`s, or a
function or closure that determines if a character matches.

Iterator behavior
The returned iterator will be a `DoubleEndedIterator` if the pattern
allows a reverse search and forward/reverse search yields the same
elements. This is true for, e.g., `char`, but not for `&str`.

If the pattern allows a reverse search but its results might differ
from a forward search, the `rmatch_indices` method can be used.

Examples

```rust
let v: Vec<_> = "abcXXXabcYYYabc".match_indices("abc").collect();
assert_eq!(v, [(0, "abc"), (6, "abc"), (12, "abc")]);

let v: Vec<_> = "1abcabc2".match_indices("abc").collect();
assert_eq!(v, [(1, "abc"), (4, "abc")]);

let v: Vec<_> = "ababa".match_indices("aba").collect();
assert_eq!(v, [(0, "aba")]); // only the first `aba`
```

```rust
pub fn rmatch_indices<P: Pattern>(&self, pat: P) -> RMatchIndices<'_, P>
where
    for<'a> P::Searcher<'a>: ReverseSearcher<'a>,
```
Returns an iterator over the disjoint matches of a pattern within `self`,
yielded in reverse order along with the index of the match.

For matches of `pat` within `self` that overlap, only the indices
corresponding to the last match are returned.

The pattern can be a `&str`, `char`, a slice of `char`s, or a
function or closure that determines if a character matches.

Iterator behavior
The returned iterator requires that the pattern supports a reverse
search, and it will be a `DoubleEndedIterator` if a forward/reverse
search yields the same elements.

For iterating from the front, the `match_indices` method can be used.

Examples

```rust
let v: Vec<_> = "abcXXXabcYYYabc".rmatch_indices("abc").collect();
assert_eq!(v, [(12, "abc"), (6, "abc"), (0, "abc")]);

let v: Vec<_> = "1abcabc2".rmatch_indices("abc").collect();
assert_eq!(v, [(4, "abc"), (1, "abc")]);

let v: Vec<_> = "ababa".rmatch_indices("aba").collect();
assert_eq!(v, [(2, "aba")]); // only the last `aba`
```

```rust
pub fn trim(&self) -> &str
```
Returns a string slice with leading and trailing whitespace removed.

‘Whitespace’ is defined according to the terms of the Unicode Derived
Core Property `White_Space`, which includes newlines.

Examples

```rust
let s = "\n Hello\tworld\t\n";

assert_eq!("Hello\tworld", s.trim());
```

```rust
pub fn trim_start(&self) -> &str
```
Returns a string slice with leading whitespace removed.

‘Whitespace’ is defined according to the terms of the Unicode Derived
Core Property `White_Space`, which includes newlines.

Text directionality
A string is a sequence of bytes. `start` in this context means the first
position of that byte string; for a left-to-right language like English or
Russian, this will be left side, and for right-to-left languages like
Arabic or Hebrew, this will be the right side.

Examples
Basic usage:

```rust
let s = "\n Hello\tworld\t\n";
assert_eq!("Hello\tworld\t\n", s.trim_start());
```

Directionality:

```rust
let s = "  English  ";
assert!(Some('E') == s.trim_start().chars().next());

let s = "  עברית  ";
assert!(Some('ע') == s.trim_start().chars().next());
```

```rust
pub fn trim_end(&self) -> &str
```
Returns a string slice with trailing whitespace removed.

‘Whitespace’ is defined according to the terms of the Unicode Derived
Core Property `White_Space`, which includes newlines.

Text directionality
A string is a sequence of bytes. `end` in this context means the last
position of that byte string; for a left-to-right language like English or
Russian, this will be right side, and for right-to-left languages like
Arabic or Hebrew, this will be the left side.

Examples
Basic usage:

```rust
let s = "\n Hello\tworld\t\n";
assert_eq!("\n Hello\tworld", s.trim_end());
```

Directionality:

```rust
let s = "  English  ";
assert!(Some('h') == s.trim_end().chars().rev().next());

let s = "  עברית  ";
assert!(Some('ת') == s.trim_end().chars().rev().next());
```

```rust
pub fn trim_left(&self) -> &str
```
Returns a string slice with leading whitespace removed.

‘Whitespace’ is defined according to the terms of the Unicode Derived
Core Property `White_Space`.

Text directionality
A string is a sequence of bytes. ‘Left’ in this context means the first
position of that byte string; for a language like Arabic or Hebrew
which are ‘right to left’ rather than ‘left to right’, this will be
the *right* side, not the left.

Examples
Basic usage:

```rust
let s = " Hello\tworld\t";

assert_eq!("Hello\tworld\t", s.trim_left());
```

Directionality:

```rust
let s = "  English";
assert!(Some('E') == s.trim_left().chars().next());

let s = "  עברית";
assert!(Some('ע') == s.trim_left().chars().next());
```

```rust
pub fn trim_right(&self) -> &str
```
Returns a string slice with trailing whitespace removed.

‘Whitespace’ is defined according to the terms of the Unicode Derived
Core Property `White_Space`.

Text directionality
A string is a sequence of bytes. ‘Right’ in this context means the last
position of that byte string; for a language like Arabic or Hebrew
which are ‘right to left’ rather than ‘left to right’, this will be
the *left* side, not the right.

Examples
Basic usage:

```rust
let s = " Hello\tworld\t";

assert_eq!(" Hello\tworld", s.trim_right());
```

Directionality:

```rust
let s = "English  ";
assert!(Some('h') == s.trim_right().chars().rev().next());

let s = "עברית  ";
assert!(Some('ת') == s.trim_right().chars().rev().next());
```

```rust
pub fn trim_matches<P: Pattern>(&self, pat: P) -> &str
where
    for<'a> P::Searcher<'a>: DoubleEndedSearcher<'a>,
```
Returns a string slice with all prefixes and suffixes that match a
pattern repeatedly removed.

The pattern can be a `char`, a slice of `char`s, or a function
or closure that determines if a character matches.

Examples
Simple patterns:

```rust
assert_eq!("11foo1bar11".trim_matches('1'), "foo1bar");
assert_eq!("123foo1bar123".trim_matches(char::is_numeric), "foo1bar");

let x: &[_] = &['1', '2'];
assert_eq!("12foo1bar12".trim_matches(x), "foo1bar");
```

A more complex pattern, using a closure:

```rust
assert_eq!("1foo1barXX".trim_matches(|c| c == '1' || c == 'X'), "foo1bar");
```

```rust
pub fn trim_start_matches<P: Pattern>(&self, pat: P) -> &str
```
Returns a string slice with all prefixes that match a pattern
repeatedly removed.

The pattern can be a `&str`, `char`, a slice of `char`s, or a
function or closure that determines if a character matches.

Text directionality
A string is a sequence of bytes. `start` in this context means the first
position of that byte string; for a left-to-right language like English or
Russian, this will be left side, and for right-to-left languages like
Arabic or Hebrew, this will be the right side.

Examples

```rust
assert_eq!("11foo1bar11".trim_start_matches('1'), "foo1bar11");
assert_eq!("123foo1bar123".trim_start_matches(char::is_numeric), "foo1bar123");

let x: &[_] = &['1', '2'];
assert_eq!("12foo1bar12".trim_start_matches(x), "foo1bar12");
```

```rust
pub fn strip_prefix<P: Pattern>(&self, prefix: P) -> Option<&str>
```
Returns a string slice with the prefix removed.

If the string starts with the pattern `prefix`, returns the substring after the prefix,
wrapped in `Some`. Unlike `trim_start_matches`, this method removes the prefix exactly once.

If the string does not start with `prefix`, returns `None`.

The pattern can be a `&str`, `char`, a slice of `char`s, or a
function or closure that determines if a character matches.

Examples

```rust
assert_eq!("foo:bar".strip_prefix("foo:"), Some("bar"));
assert_eq!("foo:bar".strip_prefix("bar"), None);
assert_eq!("foofoo".strip_prefix("foo"), Some("foo"));
```

```rust
pub fn strip_suffix<P: Pattern>(&self, suffix: P) -> Option<&str>
where
    for<'a> P::Searcher<'a>: ReverseSearcher<'a>,
```
Returns a string slice with the suffix removed.

If the string ends with the pattern `suffix`, returns the substring before the suffix,
wrapped in `Some`.  Unlike `trim_end_matches`, this method removes the suffix exactly once.

If the string does not end with `suffix`, returns `None`.

The pattern can be a `&str`, `char`, a slice of `char`s, or a
function or closure that determines if a character matches.

Examples

```rust
assert_eq!("bar:foo".strip_suffix(":foo"), Some("bar"));
assert_eq!("bar:foo".strip_suffix("bar"), None);
assert_eq!("foofoo".strip_suffix("foo"), Some("foo"));
```

```rust
pub fn strip_circumfix<P: Pattern, S: Pattern>(
    &self,
    prefix: P,
    suffix: S,
) -> Option<&str>
where
    for<'a> S::Searcher<'a>: ReverseSearcher<'a>,
```
Returns a string slice with the prefix and suffix removed.

If the string starts with the pattern `prefix` and ends with
the pattern `suffix`, and the prefix and suffix don’t overlap, returns
the substring after the prefix and before the suffix, wrapped in `Some`.
Unlike `trim_start_matches` and `trim_end_matches`, this method removes both the prefix
and suffix exactly once.

If the string does not start with `prefix`, does not end with `suffix`,
or the prefix and suffix overlap in the string, returns `None`.

Each pattern can be a `&str`, `char`, a slice of `char`s, or a
function or closure that determines if a character matches.

Examples

```rust
assert_eq!("bar:hello:foo".strip_circumfix("bar:", ":foo"), Some("hello"));
assert_eq!("bar:foo".strip_circumfix("foo", "foo"), None);
assert_eq!("foo:bar;".strip_circumfix("foo:", ';'), Some("bar"));
assert_eq!("foo:bar:baz".strip_circumfix("foo:bar:", ":bar:baz"), None);
```

```rust
pub fn trim_prefix<P: Pattern>(&self, prefix: P) -> &str
```
Returns a string slice with the optional prefix removed.

If the string starts with the pattern `prefix`, returns the substring after the prefix.
Unlike `strip_prefix`, this method always returns `&str` for easy method chaining,
instead of returning `Option<&str>`.

If the string does not start with `prefix`, returns the original string unchanged.

The pattern can be a `&str`, `char`, a slice of `char`s, or a
function or closure that determines if a character matches.

Examples

```rust
#![feature(trim_prefix_suffix)]

// Prefix present - removes it
assert_eq!("foo:bar".trim_prefix("foo:"), "bar");
assert_eq!("foofoo".trim_prefix("foo"), "foo");

// Prefix absent - returns original string
assert_eq!("foo:bar".trim_prefix("bar"), "foo:bar");

// Method chaining example
assert_eq!("<https://example.com/>".trim_prefix('<').trim_suffix('>'), "https://example.com/");
```

```rust
pub fn trim_suffix<P: Pattern>(&self, suffix: P) -> &str
where
    for<'a> P::Searcher<'a>: ReverseSearcher<'a>,
```
Returns a string slice with the optional suffix removed.

If the string ends with the pattern `suffix`, returns the substring before the suffix.
Unlike `strip_suffix`, this method always returns `&str` for easy method chaining,
instead of returning `Option<&str>`.

If the string does not end with `suffix`, returns the original string unchanged.

The pattern can be a `&str`, `char`, a slice of `char`s, or a
function or closure that determines if a character matches.

Examples

```rust
#![feature(trim_prefix_suffix)]

// Suffix present - removes it
assert_eq!("bar:foo".trim_suffix(":foo"), "bar");
assert_eq!("foofoo".trim_suffix("foo"), "foo");

// Suffix absent - returns original string
assert_eq!("bar:foo".trim_suffix("bar"), "bar:foo");

// Method chaining example
assert_eq!("<https://example.com/>".trim_prefix('<').trim_suffix('>'), "https://example.com/");
```

```rust
pub fn trim_end_matches<P: Pattern>(&self, pat: P) -> &str
where
    for<'a> P::Searcher<'a>: ReverseSearcher<'a>,
```
Returns a string slice with all suffixes that match a pattern
repeatedly removed.

The pattern can be a `&str`, `char`, a slice of `char`s, or a
function or closure that determines if a character matches.

Text directionality
A string is a sequence of bytes. `end` in this context means the last
position of that byte string; for a left-to-right language like English or
Russian, this will be right side, and for right-to-left languages like
Arabic or Hebrew, this will be the left side.

Examples
Simple patterns:

```rust
assert_eq!("11foo1bar11".trim_end_matches('1'), "11foo1bar");
assert_eq!("123foo1bar123".trim_end_matches(char::is_numeric), "123foo1bar");

let x: &[_] = &['1', '2'];
assert_eq!("12foo1bar12".trim_end_matches(x), "12foo1bar");
```

A more complex pattern, using a closure:

```rust
assert_eq!("1fooX".trim_end_matches(|c| c == '1' || c == 'X'), "1foo");
```

```rust
pub fn trim_left_matches<P: Pattern>(&self, pat: P) -> &str
```
Returns a string slice with all prefixes that match a pattern
repeatedly removed.

The pattern can be a `&str`, `char`, a slice of `char`s, or a
function or closure that determines if a character matches.

Text directionality
A string is a sequence of bytes. ‘Left’ in this context means the first
position of that byte string; for a language like Arabic or Hebrew
which are ‘right to left’ rather than ‘left to right’, this will be
the *right* side, not the left.

Examples

```rust
assert_eq!("11foo1bar11".trim_left_matches('1'), "foo1bar11");
assert_eq!("123foo1bar123".trim_left_matches(char::is_numeric), "foo1bar123");

let x: &[_] = &['1', '2'];
assert_eq!("12foo1bar12".trim_left_matches(x), "foo1bar12");
```

```rust
pub fn trim_right_matches<P: Pattern>(&self, pat: P) -> &str
where
    for<'a> P::Searcher<'a>: ReverseSearcher<'a>,
```
Returns a string slice with all suffixes that match a pattern
repeatedly removed.

The pattern can be a `&str`, `char`, a slice of `char`s, or a
function or closure that determines if a character matches.

Text directionality
A string is a sequence of bytes. ‘Right’ in this context means the last
position of that byte string; for a language like Arabic or Hebrew
which are ‘right to left’ rather than ‘left to right’, this will be
the *left* side, not the right.

Examples
Simple patterns:

```rust
assert_eq!("11foo1bar11".trim_right_matches('1'), "11foo1bar");
assert_eq!("123foo1bar123".trim_right_matches(char::is_numeric), "123foo1bar");

let x: &[_] = &['1', '2'];
assert_eq!("12foo1bar12".trim_right_matches(x), "12foo1bar");
```

A more complex pattern, using a closure:

```rust
assert_eq!("1fooX".trim_right_matches(|c| c == '1' || c == 'X'), "1foo");
```

```rust
pub fn parse<F: FromStr>(&self) -> Result<F, F::Err>
```
Parses this string slice into another type.

Because `parse` is so general, it can cause problems with type
inference. As such, `parse` is one of the few times you’ll see
the syntax affectionately known as the ‘turbofish’: `::<>`. This
helps the inference algorithm understand specifically which type
you’re trying to parse into.

`parse` can parse into any type that implements the `FromStr` trait.

Errors
Will return `Err` if it’s not possible to parse this string slice into
the desired type.

Examples
Basic usage:

```rust
let four: u32 = "4".parse().unwrap();

assert_eq!(4, four);
```

Using the ‘turbofish’ instead of annotating `four`:

```rust
let four = "4".parse::<u32>();

assert_eq!(Ok(4), four);
```

Failing to parse:

```rust
let nope = "j".parse::<u32>();

assert!(nope.is_err());
```

```rust
pub const fn is_ascii(&self) -> bool
```
Checks if all characters in this string are within the ASCII range.

An empty string returns `true`.

Examples

```rust
let ascii = "hello!\n";
let non_ascii = "Grüße, Jürgen ❤";

assert!(ascii.is_ascii());
assert!(!non_ascii.is_ascii());
```

```rust
pub const fn as_ascii(&self) -> Option<&[Char]>
```
If this string slice `is_ascii`, returns it as a slice
of ASCII characters, otherwise returns `None`.

```rust
pub const unsafe fn as_ascii_unchecked(&self) -> &[Char]
```
Converts this string slice into a slice of ASCII characters,
without checking whether they are valid.

Safety
Every character in this string must be ASCII, or else this is UB.

```rust
pub const fn eq_ignore_ascii_case(&self, other: &str) -> bool
```
Checks that two strings are an ASCII case-insensitive match.

Same as `to_ascii_lowercase(a) == to_ascii_lowercase(b)`,
but without allocating and copying temporaries.

For Unicode-aware case-insensitive matching, consider
`str::eq_ignore_case_unnormalized`.

Examples

```rust
assert!("Ferris".eq_ignore_ascii_case("FERRIS"));
assert!("Ferrös".eq_ignore_ascii_case("FERRöS"));
assert!(!"Ferrös".eq_ignore_ascii_case("FERRÖS"));
```

```rust
pub fn eq_ignore_case_unnormalized(&self, other: &str) -> bool
```
Checks that two strings are a caseless match, according to
Definition 144 in Chapter 3 of the Unicode Standard.

Same as `a.to_casefold_unnormalized() == b.to_casefold_unnormalized()`,
but without allocating. See that method’s documentation,
as well as `char::to_casefold_unnormalized()`,
for more information about case folding.

No normalization (e.g. NFC) is performed, so visually and semantically identical strings
might still compare unequal. For example, `"Å"` (U+00C5 LATIN CAPITAL LETTER A WITH RING ABOVE)
is considered distinct from `"Å"` (A followed by U+030A COMBINING RING ABOVE),
even though Unicode considers them canonically equivalent.

In addition, this method is independent of language/locale,
so the special behavior of I/ı/İ/i in Turkish and Azeri is not handled.

Examples

```rust
#![feature(casefold)]
assert!("Ferris".eq_ignore_case_unnormalized("FERRIS"));
assert!("Ferrös".eq_ignore_case_unnormalized("FERRÖS"));
assert!("ẞ".eq_ignore_case_unnormalized("ss"));
```

No NFC normalization is performed:

```rust
#![feature(casefold)]
// These two strings are visually and semantically identical...
let comp = "Å";
let decomp = "Å";

// ... but not codepoint-for-codepoint equal.
assert_eq!(comp, "\u{C5}");
assert_eq!(decomp, "A\u{030A}");

// Their case-foldings are likewise unequal:
assert!(!comp.eq_ignore_case_unnormalized(decomp));
```

```rust
pub const fn make_ascii_uppercase(&mut self)
```
Converts this string to its ASCII upper case equivalent in-place.

ASCII letters ‘a’ to ‘z’ are mapped to ‘A’ to ‘Z’,
but non-ASCII letters are unchanged.

To return a new uppercased value without modifying the existing one, use
`to_ascii_uppercase()`.

Examples

```rust
let mut s = String::from("Grüße, Jürgen ❤");

s.make_ascii_uppercase();

assert_eq!("GRüßE, JüRGEN ❤", s);
```

```rust
pub const fn make_ascii_lowercase(&mut self)
```
Converts this string to its ASCII lower case equivalent in-place.

ASCII letters ‘A’ to ‘Z’ are mapped to ‘a’ to ‘z’,
but non-ASCII letters are unchanged.

To return a new lowercased value without modifying the existing one, use
`to_ascii_lowercase()`.

Examples

```rust
let mut s = String::from("GRÜßE, JÜRGEN ❤");

s.make_ascii_lowercase();

assert_eq!("grÜße, jÜrgen ❤", s);
```

```rust
pub fn copy_from_str(&mut self, src: &str)
```
Copies the string from `src` into `self`, using a memcpy.

The length of `src` must be the same as `self`.

Panics
This function will panic if the two strings have different lengths.

Examples

```rust
#![feature(str_copy_from_str)]
let src = "Saludos";
let mut dst = String::from("Grüße, Jürgen");

// Because the strings have to be the same length,
// we slice the destination slice from sixteen bytes
// to seven. It will panic if we don't do this.
dst[..7].copy_from_str(src);

assert_eq!(src, "Saludos");
assert_eq!(dst, "Saludos, Jürgen");
```

Rust enforces that there can only be one mutable reference with no
immutable references to a particular piece of data in a particular
scope. Because of this, attempting to use `copy_from_str` on a
single string will result in a compile failure:

ⓘ
```rust
#![feature(str_copy_from_str)]
let mut string = String::from("Abcde");

string[..2].copy_from_str(&string[3..]); // compile fail!
```

To work around this, we can use `split_at_mut` to create two distinct
sub-slices from a string:

```rust
#![feature(str_copy_from_str)]
let mut string = String::from("Abcde");

{
    let (left, right) = string.split_at_mut(2);
    left.copy_from_str(&right[1..]);
}

assert_eq!(string, "decde");
```

```rust
pub const fn trim_ascii_start(&self) -> &str
```
Returns a string slice with leading ASCII whitespace removed.

‘Whitespace’ refers to the definition used by
`u8::is_ascii_whitespace`. Importantly, this definition excludes
the U+000B code point even though it has the Unicode `White_Space` property
and is removed by `str::trim_start`.

Examples

```rust
assert_eq!(" \t \u{3000}hello world\n".trim_ascii_start(), "\u{3000}hello world\n");
assert_eq!("  ".trim_ascii_start(), "");
assert_eq!("".trim_ascii_start(), "");
```

```rust
pub const fn trim_ascii_end(&self) -> &str
```
Returns a string slice with trailing ASCII whitespace removed.

‘Whitespace’ refers to the definition used by
`u8::is_ascii_whitespace`. Importantly, this definition excludes
the U+000B code point even though it has the Unicode `White_Space` property
and is removed by `str::trim_end`.

Examples

```rust
assert_eq!("\r hello world\u{3000}\n ".trim_ascii_end(), "\r hello world\u{3000}");
assert_eq!("  ".trim_ascii_end(), "");
assert_eq!("".trim_ascii_end(), "");
```

```rust
pub const fn trim_ascii(&self) -> &str
```
Returns a string slice with leading and trailing ASCII whitespace
removed.

‘Whitespace’ refers to the definition used by
`u8::is_ascii_whitespace`. Importantly, this definition excludes
the U+000B code point even though it has the Unicode `White_Space` property
and is removed by `str::trim`.

Examples

```rust
assert_eq!("\r hello world\n ".trim_ascii(), "hello world");
assert_eq!("  ".trim_ascii(), "");
assert_eq!("".trim_ascii(), "");
```

```rust
pub fn escape_debug(&self) -> EscapeDebug<'_>
```
Returns an iterator that escapes each char in `self` with `char::escape_debug`.

Note: only extended grapheme codepoints that begin the string will be
escaped.

Examples
As an iterator:

```rust
for c in "❤\n!".escape_debug() {
    print!("{c}");
}
println!();
```

Using `println!` directly:

```rust
println!("{}", "❤\n!".escape_debug());
```

Both are equivalent to:

```rust
println!("❤\\n!");
```

Using `to_string`:

```rust
assert_eq!("❤\n!".escape_debug().to_string(), "❤\\n!");
```

```rust
pub fn escape_default(&self) -> EscapeDefault<'_>
```
Returns an iterator that escapes each char in `self` with `char::escape_default`.

Examples
As an iterator:

```rust
for c in "❤\n!".escape_default() {
    print!("{c}");
}
println!();
```

Using `println!` directly:

```rust
println!("{}", "❤\n!".escape_default());
```

Both are equivalent to:

```rust
println!("\\u{{2764}}\\n!");
```

Using `to_string`:

```rust
assert_eq!("❤\n!".escape_default().to_string(), "\\u{2764}\\n!");
```

```rust
pub fn escape_unicode(&self) -> EscapeUnicode<'_>
```
Returns an iterator that escapes each char in `self` with `char::escape_unicode`.

Examples
As an iterator:

```rust
for c in "❤\n!".escape_unicode() {
    print!("{c}");
}
println!();
```

Using `println!` directly:

```rust
println!("{}", "❤\n!".escape_unicode());
```

Both are equivalent to:

```rust
println!("\\u{{2764}}\\u{{a}}\\u{{21}}");
```

Using `to_string`:

```rust
assert_eq!("❤\n!".escape_unicode().to_string(), "\\u{2764}\\u{a}\\u{21}");
```

```rust
pub fn substr_range(&self, substr: &str) -> Option<Range<usize>>
```
Returns the range that a substring points to.

Returns `None` if `substr` does not point within `self`.

Unlike `str::find`, **this does not search through the string**.
Instead, it uses pointer arithmetic to find where in the string
`substr` is derived from.

This is useful for extending `str::split` and similar methods.

Note that this method may return false positives (typically either
`Some(0..0)` or `Some(self.len()..self.len())`) if `substr` is a
zero-length `str` that points at the beginning or end of another,
independent, `str`.

Examples

```rust
use core::range::Range;

let data = "a, b, b, a";
let mut iter = data.split(", ").map(|s| data.substr_range(s).unwrap());

assert_eq!(iter.next(), Some(Range { start: 0, end: 1 }));
assert_eq!(iter.next(), Some(Range { start: 3, end: 4 }));
assert_eq!(iter.next(), Some(Range { start: 6, end: 7 }));
assert_eq!(iter.next(), Some(Range { start: 9, end: 10 }));
```

```rust
pub const fn as_str(&self) -> &str
```
Returns the same string as a string slice `&str`.

This method is redundant when used directly on `&str`, but
it helps dereferencing other string-like types to string slices,
for example references to `Box<str>` or `Arc<str>`.


# Trait Implementations

## impl AsMut<str> for str

```rust
fn as_mut(&mut self) -> &mut str
```
Converts this type into a mutable reference of the (usually inferred) input type.

## impl AsRef<ByteStr> for str

```rust
fn as_ref(&self) -> &ByteStr
```
Converts this type into a shared reference of the (usually inferred) input type.

## impl AsRef<[u8]> for str

```rust
fn as_ref(&self) -> &[u8]
```
Converts this type into a shared reference of the (usually inferred) input type.

## impl AsRef<str> for str

```rust
fn as_ref(&self) -> &str
```
Converts this type into a shared reference of the (usually inferred) input type.

## impl CloneToUninit for str

```rust
unsafe fn clone_to_uninit(&self, dest: *mut u8)
```
Performs copy-assignment from `self` to `dest`. Read more

## impl Debug for str

```rust
fn fmt(&self, f: &mut Formatter<'_>) -> Result
```
Formats the value using the given formatter. Read more

## impl Default for &str

```rust
fn default() -> Self
```
Creates an empty str

## impl Default for &mut str

```rust
fn default() -> Self
```
Creates an empty mutable str

## impl Display for str

```rust
fn fmt(&self, f: &mut Formatter<'_>) -> Result
```
Formats the value using the given formatter. Read more

## impl Hash for str

```rust
fn hash<H: Hasher>(&self, state: &mut H)
```
Feeds this value into the given `Hasher`. Read more

## impl<I> Index<I> for str where I: SliceIndex<str>,

```rust
fn index(&self, index: I) -> &I::Output
```
Performs the indexing (`container[index]`) operation. Read more

## impl<I> IndexMut<I> for str where I: SliceIndex<str>,

```rust
fn index_mut(&mut self, index: I) -> &mut I::Output
```
Performs the mutable indexing (`container[index]`) operation. Read more

## impl Ord for str

```rust
fn cmp(&self, other: &str) -> Ordering
```
This method returns an `Ordering` between `self` and `other`. Read more

## impl PartialEq for str

```rust
fn eq(&self, other: &str) -> bool
```
Equality operator `==`. Read more

```rust
fn ne(&self, other: &Rhs) -> bool
```
Inequality operator `!=`. Read more

## impl PartialEq<&str> for ByteStr

```rust
fn eq(&self, other: &&str) -> bool
```
Equality operator `==`. Read more

```rust
fn ne(&self, other: &Rhs) -> bool
```
Inequality operator `!=`. Read more

## impl PartialEq<ByteStr> for str

```rust
fn eq(&self, other: &ByteStr) -> bool
```
Equality operator `==`. Read more

```rust
fn ne(&self, other: &Rhs) -> bool
```
Inequality operator `!=`. Read more

## impl PartialEq<ByteStr> for &str

```rust
fn eq(&self, other: &ByteStr) -> bool
```
Equality operator `==`. Read more

```rust
fn ne(&self, other: &Rhs) -> bool
```
Inequality operator `!=`. Read more

## impl PartialEq<str> for ByteStr

```rust
fn eq(&self, other: &str) -> bool
```
Equality operator `==`. Read more

```rust
fn ne(&self, other: &Rhs) -> bool
```
Inequality operator `!=`. Read more

## impl PartialOrd for str

```rust
fn partial_cmp(&self, other: &str) -> Option<Ordering>
```
This method returns an ordering between `self` and `other` values if one exists. Read more

```rust
fn lt(&self, other: &Rhs) -> bool
```
Tests less than (for `self` and `other`) and is used by the `<` operator. Read more

```rust
fn le(&self, other: &Rhs) -> bool
```
Tests less than or equal to (for `self` and `other`) and is used by the
`<=` operator. Read more

```rust
fn gt(&self, other: &Rhs) -> bool
```
Tests greater than (for `self` and `other`) and is used by the `>`
operator. Read more

```rust
fn ge(&self, other: &Rhs) -> bool
```
Tests greater than or equal to (for `self` and `other`) and is used by
the `>=` operator. Read more

## impl<'b> Pattern for &'b str

```rust
fn is_prefix_of(self, haystack: &str) -> bool
```
Checks whether the pattern matches at the front of the haystack.

```rust
fn is_contained_in(self, haystack: &str) -> bool
```
Checks whether the pattern matches anywhere in the haystack

```rust
fn strip_prefix_of(self, haystack: &str) -> Option<&str>
```
Removes the pattern from the front of haystack, if it matches.

```rust
fn is_suffix_of<'a>(self, haystack: &'a str) -> bool
where
    Self::Searcher<'a>: ReverseSearcher<'a>,
```
Checks whether the pattern matches at the back of the haystack.

```rust
fn strip_suffix_of<'a>(self, haystack: &'a str) -> Option<&'a str>
where
    Self::Searcher<'a>: ReverseSearcher<'a>,
```
Removes the pattern from the back of haystack, if it matches.

```rust
fn into_searcher(self, haystack: &str) -> StrSearcher<'_, 'b>
```
Constructs the associated searcher from
`self` and the `haystack` to search in.

```rust
fn as_utf8_pattern(&self) -> Option<Utf8Pattern<'_>>
```
Returns the pattern as UTF-8 if possible.

## impl SliceIndex<str> for RangeFull

```rust
fn get(self, slice: &str) -> Option<&Self::Output>
```
Returns a shared reference to the output at this location, if in
bounds.

```rust
fn get_mut(self, slice: &mut str) -> Option<&mut Self::Output>
```
Returns a mutable reference to the output at this location, if in
bounds.

```rust
unsafe fn get_unchecked(self, slice: *const str) -> *const Self::Output
```
Returns a pointer to the output at this location, without
performing any bounds checking. Read more

```rust
unsafe fn get_unchecked_mut(self, slice: *mut str) -> *mut Self::Output
```
Returns a mutable pointer to the output at this location, without
performing any bounds checking. Read more

```rust
fn index(self, slice: &str) -> &Self::Output
```
Returns a shared reference to the output at this location, panicking
if out of bounds.

```rust
fn index_mut(self, slice: &mut str) -> &mut Self::Output
```
Returns a mutable reference to the output at this location, panicking
if out of bounds.

## impl SliceIndex<str> for Range<usize>

```rust
fn get(self, slice: &str) -> Option<&Self::Output>
```
Returns a shared reference to the output at this location, if in
bounds.

```rust
fn get_mut(self, slice: &mut str) -> Option<&mut Self::Output>
```
Returns a mutable reference to the output at this location, if in
bounds.

```rust
unsafe fn get_unchecked(self, slice: *const str) -> *const Self::Output
```
Returns a pointer to the output at this location, without
performing any bounds checking. Read more

```rust
unsafe fn get_unchecked_mut(self, slice: *mut str) -> *mut Self::Output
```
Returns a mutable pointer to the output at this location, without
performing any bounds checking. Read more

```rust
fn index(self, slice: &str) -> &Self::Output
```
Returns a shared reference to the output at this location, panicking
if out of bounds.

```rust
fn index_mut(self, slice: &mut str) -> &mut Self::Output
```
Returns a mutable reference to the output at this location, panicking
if out of bounds.

## impl SliceIndex<str> for Range<usize>

```rust
fn get(self, slice: &str) -> Option<&Self::Output>
```
Returns a shared reference to the output at this location, if in
bounds.

```rust
fn get_mut(self, slice: &mut str) -> Option<&mut Self::Output>
```
Returns a mutable reference to the output at this location, if in
bounds.

```rust
unsafe fn get_unchecked(self, slice: *const str) -> *const Self::Output
```
Returns a pointer to the output at this location, without
performing any bounds checking. Read more

```rust
unsafe fn get_unchecked_mut(self, slice: *mut str) -> *mut Self::Output
```
Returns a mutable pointer to the output at this location, without
performing any bounds checking. Read more

```rust
fn index(self, slice: &str) -> &Self::Output
```
Returns a shared reference to the output at this location, panicking
if out of bounds.

```rust
fn index_mut(self, slice: &mut str) -> &mut Self::Output
```
Returns a mutable reference to the output at this location, panicking
if out of bounds.

## impl SliceIndex<str> for (Bound<usize>, Bound<usize>)

```rust
fn get(self, slice: &str) -> Option<&str>
```
Returns a shared reference to the output at this location, if in
bounds.

```rust
fn get_mut(self, slice: &mut str) -> Option<&mut str>
```
Returns a mutable reference to the output at this location, if in
bounds.

```rust
unsafe fn get_unchecked(self, slice: *const str) -> *const str
```
Returns a pointer to the output at this location, without
performing any bounds checking. Read more

```rust
unsafe fn get_unchecked_mut(self, slice: *mut str) -> *mut str
```
Returns a mutable pointer to the output at this location, without
performing any bounds checking. Read more

```rust
fn index(self, slice: &str) -> &str
```
Returns a shared reference to the output at this location, panicking
if out of bounds.

```rust
fn index_mut(self, slice: &mut str) -> &mut str
```
Returns a mutable reference to the output at this location, panicking
if out of bounds.

## impl SliceIndex<str> for RangeTo<usize>

```rust
fn get(self, slice: &str) -> Option<&Self::Output>
```
Returns a shared reference to the output at this location, if in
bounds.

```rust
fn get_mut(self, slice: &mut str) -> Option<&mut Self::Output>
```
Returns a mutable reference to the output at this location, if in
bounds.

```rust
unsafe fn get_unchecked(self, slice: *const str) -> *const Self::Output
```
Returns a pointer to the output at this location, without
performing any bounds checking. Read more

```rust
unsafe fn get_unchecked_mut(self, slice: *mut str) -> *mut Self::Output
```
Returns a mutable pointer to the output at this location, without
performing any bounds checking. Read more

```rust
fn index(self, slice: &str) -> &Self::Output
```
Returns a shared reference to the output at this location, panicking
if out of bounds.

```rust
fn index_mut(self, slice: &mut str) -> &mut Self::Output
```
Returns a mutable reference to the output at this location, panicking
if out of bounds.

## impl SliceIndex<str> for RangeFrom<usize>

```rust
fn get(self, slice: &str) -> Option<&Self::Output>
```
Returns a shared reference to the output at this location, if in
bounds.

```rust
fn get_mut(self, slice: &mut str) -> Option<&mut Self::Output>
```
Returns a mutable reference to the output at this location, if in
bounds.

```rust
unsafe fn get_unchecked(self, slice: *const str) -> *const Self::Output
```
Returns a pointer to the output at this location, without
performing any bounds checking. Read more

```rust
unsafe fn get_unchecked_mut(self, slice: *mut str) -> *mut Self::Output
```
Returns a mutable pointer to the output at this location, without
performing any bounds checking. Read more

```rust
fn index(self, slice: &str) -> &Self::Output
```
Returns a shared reference to the output at this location, panicking
if out of bounds.

```rust
fn index_mut(self, slice: &mut str) -> &mut Self::Output
```
Returns a mutable reference to the output at this location, panicking
if out of bounds.

## impl SliceIndex<str> for RangeFrom<usize>

```rust
fn get(self, slice: &str) -> Option<&Self::Output>
```
Returns a shared reference to the output at this location, if in
bounds.

```rust
fn get_mut(self, slice: &mut str) -> Option<&mut Self::Output>
```
Returns a mutable reference to the output at this location, if in
bounds.

```rust
unsafe fn get_unchecked(self, slice: *const str) -> *const Self::Output
```
Returns a pointer to the output at this location, without
performing any bounds checking. Read more

```rust
unsafe fn get_unchecked_mut(self, slice: *mut str) -> *mut Self::Output
```
Returns a mutable pointer to the output at this location, without
performing any bounds checking. Read more

```rust
fn index(self, slice: &str) -> &Self::Output
```
Returns a shared reference to the output at this location, panicking
if out of bounds.

```rust
fn index_mut(self, slice: &mut str) -> &mut Self::Output
```
Returns a mutable reference to the output at this location, panicking
if out of bounds.

## impl SliceIndex<str> for RangeInclusive<usize>

```rust
fn get(self, slice: &str) -> Option<&Self::Output>
```
Returns a shared reference to the output at this location, if in
bounds.

```rust
fn get_mut(self, slice: &mut str) -> Option<&mut Self::Output>
```
Returns a mutable reference to the output at this location, if in
bounds.

```rust
unsafe fn get_unchecked(self, slice: *const str) -> *const Self::Output
```
Returns a pointer to the output at this location, without
performing any bounds checking. Read more

```rust
unsafe fn get_unchecked_mut(self, slice: *mut str) -> *mut Self::Output
```
Returns a mutable pointer to the output at this location, without
performing any bounds checking. Read more

```rust
fn index(self, slice: &str) -> &Self::Output
```
Returns a shared reference to the output at this location, panicking
if out of bounds.

```rust
fn index_mut(self, slice: &mut str) -> &mut Self::Output
```
Returns a mutable reference to the output at this location, panicking
if out of bounds.

## impl SliceIndex<str> for RangeInclusive<usize>

```rust
fn get(self, slice: &str) -> Option<&Self::Output>
```
Returns a shared reference to the output at this location, if in
bounds.

```rust
fn get_mut(self, slice: &mut str) -> Option<&mut Self::Output>
```
Returns a mutable reference to the output at this location, if in
bounds.

```rust
unsafe fn get_unchecked(self, slice: *const str) -> *const Self::Output
```
Returns a pointer to the output at this location, without
performing any bounds checking. Read more

```rust
unsafe fn get_unchecked_mut(self, slice: *mut str) -> *mut Self::Output
```
Returns a mutable pointer to the output at this location, without
performing any bounds checking. Read more

```rust
fn index(self, slice: &str) -> &Self::Output
```
Returns a shared reference to the output at this location, panicking
if out of bounds.

```rust
fn index_mut(self, slice: &mut str) -> &mut Self::Output
```
Returns a mutable reference to the output at this location, panicking
if out of bounds.

## impl SliceIndex<str> for RangeToInclusive<usize>

```rust
fn get(self, slice: &str) -> Option<&Self::Output>
```
Returns a shared reference to the output at this location, if in
bounds.

```rust
fn get_mut(self, slice: &mut str) -> Option<&mut Self::Output>
```
Returns a mutable reference to the output at this location, if in
bounds.

```rust
unsafe fn get_unchecked(self, slice: *const str) -> *const Self::Output
```
Returns a pointer to the output at this location, without
performing any bounds checking. Read more

```rust
unsafe fn get_unchecked_mut(self, slice: *mut str) -> *mut Self::Output
```
Returns a mutable pointer to the output at this location, without
performing any bounds checking. Read more

```rust
fn index(self, slice: &str) -> &Self::Output
```
Returns a shared reference to the output at this location, panicking
if out of bounds.

```rust
fn index_mut(self, slice: &mut str) -> &mut Self::Output
```
Returns a mutable reference to the output at this location, panicking
if out of bounds.

## impl SliceIndex<str> for RangeToInclusive<usize>

```rust
fn get(self, slice: &str) -> Option<&Self::Output>
```
Returns a shared reference to the output at this location, if in
bounds.

```rust
fn get_mut(self, slice: &mut str) -> Option<&mut Self::Output>
```
Returns a mutable reference to the output at this location, if in
bounds.

```rust
unsafe fn get_unchecked(self, slice: *const str) -> *const Self::Output
```
Returns a pointer to the output at this location, without
performing any bounds checking. Read more

```rust
unsafe fn get_unchecked_mut(self, slice: *mut str) -> *mut Self::Output
```
Returns a mutable pointer to the output at this location, without
performing any bounds checking. Read more

```rust
fn index(self, slice: &str) -> &Self::Output
```
Returns a shared reference to the output at this location, panicking
if out of bounds.

```rust
fn index_mut(self, slice: &mut str) -> &mut Self::Output
```
Returns a mutable reference to the output at this location, panicking
if out of bounds.

## impl<'a> TryFrom<&'a ByteStr> for &'a str

```rust
fn try_from(s: &'a ByteStr) -> Result<Self, Self::Error>
```
Performs the conversion.

## impl<'a> TryFrom<&'a mut ByteStr> for &'a mut str

```rust
fn try_from(s: &'a mut ByteStr) -> Result<Self, Self::Error>
```
Performs the conversion.

## impl !Error for &str

## impl ConstParamTy_ for str

## impl Eq for str

## impl StructuralPartialEq for str


# Auto Trait Implementations

## impl !Sized for str

## impl Freeze for str

## impl RefUnwindSafe for str

## impl Send for str

## impl Sync for str

## impl Unpin for str

## impl UnsafeUnpin for str

## impl UnwindSafe for str



# Blanket Implementations

## impl<T> Any for T where T: 'static + ?Sized,

```rust
fn type_id(&self) -> TypeId
```
Gets the `TypeId` of `self`. Read more

## impl<T> Borrow<T> for T where T: ?Sized,

```rust
fn borrow(&self) -> &T
```
Immutably borrows from an owned value. Read more

## impl<T> BorrowMut<T> for T where T: ?Sized,

```rust
fn borrow_mut(&mut self) -> &mut T
```
Mutably borrows from an owned value. Read more


# In crate core

## Modules

- [alloc](https://doc.rust-lang.org/core/alloc/index.html)
- [any](https://doc.rust-lang.org/core/any/index.html)
- [arch](https://doc.rust-lang.org/core/arch/index.html)
- [array](https://doc.rust-lang.org/core/array/index.html)
- [ascii](https://doc.rust-lang.org/core/ascii/index.html)
- [async_iter](https://doc.rust-lang.org/core/async_iter/index.html)
- [autodiff](https://doc.rust-lang.org/core/autodiff/index.html)
- [borrow](https://doc.rust-lang.org/core/borrow/index.html)
- [bstr](https://doc.rust-lang.org/core/bstr/index.html)
- [cell](https://doc.rust-lang.org/core/cell/index.html)
- [char](https://doc.rust-lang.org/core/char/index.html)
- [clone](https://doc.rust-lang.org/core/clone/index.html)
- [cmp](https://doc.rust-lang.org/core/cmp/index.html)
- [contracts](https://doc.rust-lang.org/core/contracts/index.html)
- [convert](https://doc.rust-lang.org/core/convert/index.html)
- [default](https://doc.rust-lang.org/core/default/index.html)
- [error](https://doc.rust-lang.org/core/error/index.html)
- [f128](https://doc.rust-lang.org/core/f128/index.html)
- [f16](https://doc.rust-lang.org/core/f16/index.html)
- [f32](https://doc.rust-lang.org/core/f32/index.html)
- [f64](https://doc.rust-lang.org/core/f64/index.html)
- [ffi](https://doc.rust-lang.org/core/ffi/index.html)
- [field](https://doc.rust-lang.org/core/field/index.html)
- [fmt](https://doc.rust-lang.org/core/fmt/index.html)
- [from](https://doc.rust-lang.org/core/from/index.html)
- [future](https://doc.rust-lang.org/core/future/index.html)
- [hash](https://doc.rust-lang.org/core/hash/index.html)
- [hint](https://doc.rust-lang.org/core/hint/index.html)
- [i128](https://doc.rust-lang.org/core/i128/index.html)
- [i16](https://doc.rust-lang.org/core/i16/index.html)
- [i32](https://doc.rust-lang.org/core/i32/index.html)
- [i64](https://doc.rust-lang.org/core/i64/index.html)
- [i8](https://doc.rust-lang.org/core/i8/index.html)
- [index](https://doc.rust-lang.org/core/index/index.html)
- [intrinsics](https://doc.rust-lang.org/core/intrinsics/index.html)
- [io](https://doc.rust-lang.org/core/io/index.html)
- [isize](https://doc.rust-lang.org/core/isize/index.html)
- [iter](https://doc.rust-lang.org/core/iter/index.html)
- [marker](https://doc.rust-lang.org/core/marker/index.html)
- [mem](https://doc.rust-lang.org/core/mem/index.html)
- [net](https://doc.rust-lang.org/core/net/index.html)
- [num](https://doc.rust-lang.org/core/num/index.html)
- [offload](https://doc.rust-lang.org/core/offload/index.html)
- [ops](https://doc.rust-lang.org/core/ops/index.html)
- [option](https://doc.rust-lang.org/core/option/index.html)
- [os](https://doc.rust-lang.org/core/os/index.html)
- [panic](https://doc.rust-lang.org/core/panic/index.html)
- [panicking](https://doc.rust-lang.org/core/panicking/index.html)
- [pat](https://doc.rust-lang.org/core/pat/index.html)
- [pin](https://doc.rust-lang.org/core/pin/index.html)
- [prelude](https://doc.rust-lang.org/core/prelude/index.html)
- [primitive](https://doc.rust-lang.org/core/primitive/index.html)
- [process](https://doc.rust-lang.org/core/process/index.html)
- [profiling](https://doc.rust-lang.org/core/profiling/index.html)
- [ptr](https://doc.rust-lang.org/core/ptr/index.html)
- [random](https://doc.rust-lang.org/core/random/index.html)
- [range](https://doc.rust-lang.org/core/range/index.html)
- [result](https://doc.rust-lang.org/core/result/index.html)
- [simd](https://doc.rust-lang.org/core/simd/index.html)
- [slice](https://doc.rust-lang.org/core/slice/index.html)
- [str](https://doc.rust-lang.org/core/str/index.html)
- [sync](https://doc.rust-lang.org/core/sync/index.html)
- [task](https://doc.rust-lang.org/core/task/index.html)
- [time](https://doc.rust-lang.org/core/time/index.html)
- [u128](https://doc.rust-lang.org/core/u128/index.html)
- [u16](https://doc.rust-lang.org/core/u16/index.html)
- [u32](https://doc.rust-lang.org/core/u32/index.html)
- [u64](https://doc.rust-lang.org/core/u64/index.html)
- [u8](https://doc.rust-lang.org/core/u8/index.html)
- [ub_checks](https://doc.rust-lang.org/core/ub_checks/index.html)
- [unsafe_binder](https://doc.rust-lang.org/core/unsafe_binder/index.html)
- [usize](https://doc.rust-lang.org/core/usize/index.html)
- [view](https://doc.rust-lang.org/core/view/index.html)

## Macros

- [assert](https://doc.rust-lang.org/core/macro.assert.html)
- [assert_eq](https://doc.rust-lang.org/core/macro.assert_eq.html)
- [assert_matches](https://doc.rust-lang.org/core/macro.assert_matches.html)
- [assert_ne](https://doc.rust-lang.org/core/macro.assert_ne.html)
- [assert_unsafe_precondition](https://doc.rust-lang.org/core/macro.assert_unsafe_precondition.html)
- [cfg](https://doc.rust-lang.org/core/macro.cfg.html)
- [cfg_select](https://doc.rust-lang.org/core/macro.cfg_select.html)
- [column](https://doc.rust-lang.org/core/macro.column.html)
- [compile_error](https://doc.rust-lang.org/core/macro.compile_error.html)
- [concat](https://doc.rust-lang.org/core/macro.concat.html)
- [concat_bytes](https://doc.rust-lang.org/core/macro.concat_bytes.html)
- [const_format_args](https://doc.rust-lang.org/core/macro.const_format_args.html)
- [debug_assert](https://doc.rust-lang.org/core/macro.debug_assert.html)
- [debug_assert_eq](https://doc.rust-lang.org/core/macro.debug_assert_eq.html)
- [debug_assert_matches](https://doc.rust-lang.org/core/macro.debug_assert_matches.html)
- [debug_assert_ne](https://doc.rust-lang.org/core/macro.debug_assert_ne.html)
- [direct_const_arg](https://doc.rust-lang.org/core/macro.direct_const_arg.html)
- [env](https://doc.rust-lang.org/core/macro.env.html)
- [file](https://doc.rust-lang.org/core/macro.file.html)
- [format_args](https://doc.rust-lang.org/core/macro.format_args.html)
- [include](https://doc.rust-lang.org/core/macro.include.html)
- [include_bytes](https://doc.rust-lang.org/core/macro.include_bytes.html)
- [include_str](https://doc.rust-lang.org/core/macro.include_str.html)
- [line](https://doc.rust-lang.org/core/macro.line.html)
- [log_syntax](https://doc.rust-lang.org/core/macro.log_syntax.html)
- [matches](https://doc.rust-lang.org/core/macro.matches.html)
- [module_path](https://doc.rust-lang.org/core/macro.module_path.html)
- [offload](https://doc.rust-lang.org/core/macro.offload.html)
- [option_env](https://doc.rust-lang.org/core/macro.option_env.html)
- [panic](https://doc.rust-lang.org/core/macro.panic.html)
- [pattern_type](https://doc.rust-lang.org/core/macro.pattern_type.html)
- [stringify](https://doc.rust-lang.org/core/macro.stringify.html)
- [todo](https://doc.rust-lang.org/core/macro.todo.html)
- [trace_macros](https://doc.rust-lang.org/core/macro.trace_macros.html)
- [try](https://doc.rust-lang.org/core/macro.try.html)
- [unimplemented](https://doc.rust-lang.org/core/macro.unimplemented.html)
- [unreachable](https://doc.rust-lang.org/core/macro.unreachable.html)
- [view_type](https://doc.rust-lang.org/core/macro.view_type.html)
- [write](https://doc.rust-lang.org/core/macro.write.html)
- [writeln](https://doc.rust-lang.org/core/macro.writeln.html)

## Primitive Types

- [array](https://doc.rust-lang.org/core/primitive.array.html)
- [bool](https://doc.rust-lang.org/core/primitive.bool.html)
- [char](https://doc.rust-lang.org/core/primitive.char.html)
- [f128](https://doc.rust-lang.org/core/primitive.f128.html)
- [f16](https://doc.rust-lang.org/core/primitive.f16.html)
- [f32](https://doc.rust-lang.org/core/primitive.f32.html)
- [f64](https://doc.rust-lang.org/core/primitive.f64.html)
- [fn](https://doc.rust-lang.org/core/primitive.fn.html)
- [i128](https://doc.rust-lang.org/core/primitive.i128.html)
- [i16](https://doc.rust-lang.org/core/primitive.i16.html)
- [i32](https://doc.rust-lang.org/core/primitive.i32.html)
- [i64](https://doc.rust-lang.org/core/primitive.i64.html)
- [i8](https://doc.rust-lang.org/core/primitive.i8.html)
- [isize](https://doc.rust-lang.org/core/primitive.isize.html)
- [never](https://doc.rust-lang.org/core/primitive.never.html)
- [pointer](https://doc.rust-lang.org/core/primitive.pointer.html)
- [reference](https://doc.rust-lang.org/core/primitive.reference.html)
- [slice](https://doc.rust-lang.org/core/primitive.slice.html)
- [str](https://doc.rust-lang.org/core/primitive.str.html)
- [tuple](https://doc.rust-lang.org/core/primitive.tuple.html)
- [u128](https://doc.rust-lang.org/core/primitive.u128.html)
- [u16](https://doc.rust-lang.org/core/primitive.u16.html)
- [u32](https://doc.rust-lang.org/core/primitive.u32.html)
- [u64](https://doc.rust-lang.org/core/primitive.u64.html)
- [u8](https://doc.rust-lang.org/core/primitive.u8.html)
- [unit](https://doc.rust-lang.org/core/primitive.unit.html)
- [usize](https://doc.rust-lang.org/core/primitive.usize.html)

