# Help, my Decoder just gave a runtime exception!

The most straightforward approach to this type of decoder, is to create a
branch-decoder, a leaf-decoder and a tree-decoder, which would look something
like this:

```elm
decoder : Decoder Tree
decoder =
    oneOf
        [ branchDecoder
        , leafDecoder
        ]


branchDecoder : Decoder Tree
branchDecoder =
    map2 Branch
        (field "name" string)
        (field "children" (list decoder))


leafDecoder : Decoder Tree
leafDecoder =
    map2 Leaf
        (field "name" string)
        (field "value" int)
```

Since we work with an eager language, that can't work - `decoder` and
`branchDecoder` refer to one another without any laziness being introduced, and
the compiler will tell you about it:

```
The following definitions depend directly on each other:

    ┌─────┐
    │    branchDecoder
    │     ↓
    │    decoder
    └─────┘

You seem to have a fairly tricky case, so I very highly recommend reading this:
<https://github.com/elm-lang/elm-compiler/blob/0.18.0/hints/bad-recursion.md> It
will help you really understand the problem and how to fix it. Read it!
```

So, after reading that document, you know you need to introduce laziness using  
- in this case - `Json.Decode.lazy`. You may be wondering _where_ to put the
call to `lazy` - should you lazily refer to `branchDecoder` from `decoder`, or
should you lazily refer to `decoder` from `branchDecoder`?

The answer is: **there is no way to know** _for sure_.

See, Elm orders its output based on how strongly connected different components are. In other words, a function that has more dependencies is more likely to appear later, a function that has fewer dependencies is more likely to appear earlier. In our case, that makes the most likely order `leafDecoder -> branchDecoder -> decoder`.

If we lazily refer to `branchDecoder` from `decoder`, this order doesn't change; and `branchDecoder` will still _eagerly_ refer to `decoder` whose definition appears only later in the compiled code.

```elm
decoder : Decoder Tree
decoder =
    oneOf
        [ lazy (\_ -> branchDecoder)
        , leafDecoder
        ]


branchDecoder : Decoder Tree
branchDecoder =
    map2 Branch
        (field "name" string)
        (field "children" (list decoder))


leafDecoder : Decoder Tree
leafDecoder =
    map2 Leaf
        (field "name" string)
        (field "value" int)
```

The above results in the following result - slightly cleaned up to make it a
little more readable.

```js
var leafDecoder = A3(
	map2,
	Leaf,
	A2(field, 'name', string),
	A2(field, 'value', int));
var branchDecoder = A3(
	map2,
	Branch,
	A2(field, 'name', string),
	A2(
		field,
		'children',
		list(decoder)));
var decoder = oneOf(
	{
		ctor: '::',
		_0: lazy(
			function (_p0) {
				return branchDecoder;
			}),
		_1: {
			ctor: '::',
			_0: leafDecoder,
			_1: {ctor: '[]'}
		}
	});
```

Notice that there's only a single `function` definition in this whole thing -
everything else is eagerly evaluated and has all of its argument available.
Note, also, that `branchDecoder` is defined _before_ `decoder` is defined; yet
it references `decoder`. Since only function declarations are hoisted to the
top in JavaScript; the above code can't actually work! `decoder` will be
**undefined** when `branchDecoder` is used.

So our next option is to place the `lazy` call in `branchDecoder` and see if
that works:

```elm
decoder : Decoder Tree
decoder =
    oneOf
        [ branchDecoder
        , leafDecoder
        ]


branchDecoder : Decoder Tree
branchDecoder =
    map2 Branch
        (field "name" string)
        (field "children" (list <| lazy (\_ -> decoder)))


leafDecoder : Decoder Tree
leafDecoder =
    map2 Leaf
        (field "name" string)
        (field "value" int)
```

In the compiled result, we see that we have actually achieved our goal:

```js
var leafDecoder = A3(
	map2,
	Leaf,
	A2(field, 'name', string),
	A2(field, 'value', int));
var branchDecoder = A3(
	map2,
	Branch,
	A2(field, 'name', string),
	A2(
		field,
		'children',
		list(
			lazy(
				function (_p0) {
					return decoder;
				}))));
var decoder = oneOf(
	{
		ctor: '::',
		_0: branchDecoder,
		_1: {
			ctor: '::',
			_0: leafDecoder,
			_1: {ctor: '[]'}
		}
	});
```

Yay, success!

However, the order in which compiled results appear in the output isn't
something you, while writing Elm code, should worry about. Figuring out the
strongly connected components to figure out where the `lazy` should go, is not
what you want to be worrying about. So the safest option when dealing with 2
functions that refer to one another, is to introduce laziness at both places:

```elm
decoder : Decoder Tree
decoder =
    oneOf
        [ lazy (\_ -> branchDecoder)
        , leafDecoder
        ]


branchDecoder : Decoder Tree
branchDecoder =
    map2 Branch
        (field "name" string)
        (field "children" (list <| lazy (\_ -> decoder)))


leafDecoder : Decoder Tree
leafDecoder =
    map2 Leaf
        (field "name" string)
        (field "value" int)
```
