# Exercises

## Exercise 01

-> primitive

```js
var input = 5;
```

```elm
output =
    5
```

## Exercise 02

-> combining primitives

```js
var input = [ "foo", "bar", "baz" ];
```

```elm
output =
    [ "foo", "bar", "baz" ]
```

## Exercise 03

-> introducing map

```js
var input = [ "foo", "bar", "baz" ];
```

```elm
output =
    [ "FOO", "BAR", "BAZ" ]
```

## Exercise 04

-> introducing field


```js
var input = { "age": 50 }
```

```elm
output =
    50
```

## Exercise 05

-> more map: map2
-> perhaps we can find a better function here? Something that isn't a constructor.
-> how about String.repeat?

```js
var input = { "term": "foo", "repeat": 3 };
```

```elm
output =
    "foofoofoo"
```

## Exercise 06

-> map2, and intro to decoding records.
-> introduce magic constructors for fields with a type alias

```js
var input = { "name": "Josh", "age": 50 };
```

```elm
output =
    Person "Josh" 50
```

## Exercise 07

-> succeed

```js
var input = *random JS variable*;
```

```elm
output =
    "sure."
```

## Exercise 08

-> input + succeed/fail

```
decode "green" == succeed Green
```

## Exercise 09

-> full on union type decoder!
