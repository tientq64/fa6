rules = Array.from linkEl.sheet.rules
kind = void
icons = rules
	.map (rule) ~>
		selector = rule.selectorText
		if selector
			names = selector
				.split /,\s?/
				.map (name) ~>
					mat = /\.fa-([-\w]+)::before/.exec name
					mat and mat.1
				.filter Boolean
			if names.length
				name = names.at -1
				unless name in <[swap-opacity stack-2x]>
					if name is \500px
						kind := \fab
					names: names
					name: name
					kind: kind
	.filter Boolean

App =
	oninit: !->
		for k, val of @
			@[k] = val.bind @ if typeof val is \function
		@kind = \far
		@size = \2x

	oncreate: !->
		addEventListener \keydown @onkeydown

	onkeydown: (event) !->
		unless event.repeat or event.ctrlKey
			switch event.code
			| \KeyS
				@kind = \fas
				m.redraw!
			| \KeyR
				@kind = \far
				m.redraw!
			| \KeyL
				@kind = \fal
				m.redraw!
			| \KeyT
				@kind = \fat
				m.redraw!
			| \KeyD
				@kind = \fad
				m.redraw!
			| \Digit1
				@size = \1x
				m.redraw!
			| \Digit2
				@size = \2x
				m.redraw!
			| \Digit3
				@size = \3x
				m.redraw!
			| \Digit4
				@size = \4x
				m.redraw!
			| \Digit5
				@size = \5x
				m.redraw!

	view: ->
		m \.grid.grid-cols-3.md:grid-cols-6.lg:grid-cols-12.auto-rows-fr.gap-1.p-1.text-center.break-words.bg-gray-50.text-gray-800,
			icons.map (icon) ~>
				m \.flex.flex-col.justify-center.rounded-lg.cursor-pointer.hover:bg-gray-800.hover:text-white,
					onclick: (event) !~>
						navigator.clipboard.writeText icon.name
					m \i,
						class: "#{icon.kind or @kind} fa-#{icon.name} fa-#@size"
					m \.text-sm,
						icon.name

m.mount appEl, App
