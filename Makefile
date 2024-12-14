write:
	flatpak run com.github.marktext.marktext &

umark:
	python3 update_markdown.py

ushell:
	python3 update_shell.py

source:
	bash -i -c "source ./shell_git_bible.sh"

lint:
	flake8 *.py

test:
	pytest
	./tests/shell/test_bible.sh

help:
	@echo "Available make commands:"
	@echo "  write    - Open MarkText for editing."
	@echo "  umark    - Update Markdown file from Python script."
	@echo "  ushell   - Update Shell script from Python script."
	@echo "  source   - Source the shell_git_bible.sh file."
	@echo "  lint     - Lint Python files recursively."
	@echo "  test     - Run Python and Bash tests."
