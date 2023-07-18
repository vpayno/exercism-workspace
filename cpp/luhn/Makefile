.PHONY: clean
clean:
	rm -rf ./build

.PHONY: test
test: clean
	mkdir -pv ./build

	@printf "\n"
	@# each line is executed in a subshell, we have to daisy chain them so they
	@# run in the build directory
	cd ./build; export LDFLAGS="-lgcov --coverage" CXXFLAGS="--coverage"; cmake -DEXERCISM_RUN_ALL_TESTS=1 -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -G 'Unix Makefiles' ../; if make; then printf "\n=== All Tests Passed ===\n"; else printf "\n=== Test Failure ===\n"; false; fi

.PHONY: coverage
coverage: test
	@printf "\n"
	find . -regextype posix-egrep -regex "^.*(tests-main|CompilerId).*[.](gcda|gcno)$$" -print -delete

	@printf "\n"
	find . -regextype posix-egrep -regex "^.*[.](gcda|gcno)28520"

	@printf "\n"
	gcovr --print-summary
