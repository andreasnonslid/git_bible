from shared import FileProcessor, add_prefix, write_line, toggle_state, CODEBLOCK_DELIMITER

class MarkdownToShellProcessor(FileProcessor):
    def __init__(self):
        super().__init__("markdown_git_bible.md", "shell_git_bible.sh")

    def process_lines(self, infile, outfile):
        commenting = True

        for line in infile:
            if line.strip().startswith(CODEBLOCK_DELIMITER):
                commenting = toggle_state(commenting)
                continue

            if commenting:
                line = add_prefix(line)

            write_line(outfile, line)

if __name__ == "__main__":
    processor = MarkdownToShellProcessor()
    processor.process()
