from shared import FileProcessor, is_prefixed, remove_prefix, startstop_codeblock, end_codeblock, write_line

class ShellToMarkdownProcessor(FileProcessor):
    def __init__(self):
        super().__init__("shell_git_bible.sh", "markdown_git_bible.md")

    def process_lines(self, infile, outfile):
        codeblock_open = False
        prev_line_prefixed = False

        for line in infile:
            current_line_prefixed = is_prefixed(line)

            if current_line_prefixed:
                line = remove_prefix(line)

            if current_line_prefixed and not prev_line_prefixed and codeblock_open:
                end_codeblock(outfile)
                codeblock_open = False

            if not current_line_prefixed and prev_line_prefixed:
                startstop_codeblock(outfile, language="bash")
                codeblock_open = True

            write_line(outfile, line)

            prev_line_prefixed = current_line_prefixed

        if codeblock_open:
            end_codeblock(outfile)

if __name__ == "__main__":
    processor = ShellToMarkdownProcessor()
    processor.process()
