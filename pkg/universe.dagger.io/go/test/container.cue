package go

import (
	"dagger.io/dagger"
	"universe.dagger.io/go"
	"universe.dagger.io/alpine"
)

dagger.#Plan & {
	actions: tests: container: {
		_source: dagger.#Scratch & {}

		simple: go.#Container & {
			source: _source
			command: args: ["version"]
		}

		overide: {
			base: alpine.#Build & {
				packages: go: _
			}

			command: go.#Container & {
				input:  base.output
				source: _source
				command: args: ["version"]
			}
		}
	}
}