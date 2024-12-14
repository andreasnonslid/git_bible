from pathlib import Path

# Global variables for forced configuration
PREFIX = "#"
CODEBLOCK_DELIMITER = "```"

class FileProcessor:
    def __init__(self, input_file_name, output_file_name):
        self._input_file = Path(input_file_name)
        self._output_file = Path(output_file_name)

    def validate_files(self):
        if not self._input_file.exists():
            raise FileNotFoundError(f"The file {self._input_file} does not exist.")

        print(f"Found input file: {self._input_file}")

        if not self._output_file.exists():
            self._output_file.touch()

    def start_conversion(self):
        print(f"Starting conversion from {self._input_file} to {self._output_file}...")

    def end_conversion(self):
        print(f"Successfully converted {self._input_file} to {self._output_file}.")

    def process_lines(self, infile, outfile):
        raise NotImplementedError("Subclasses must override process_lines.")

    def process(self):
        self.validate_files()
        self.start_conversion()

        with self._input_file.open("r") as infile, self._output_file.open("w") as outfile:
            self.process_lines(infile, outfile)

        self.end_conversion()

# Helper functions

def is_prefixed(line, prefix=PREFIX):
    return line.startswith(prefix)

def add_prefix(line, prefix=PREFIX):
    return f"{prefix}{line}" if line.strip() else f"{prefix}\n"

def remove_prefix(line, prefix=PREFIX):
    return line[len(prefix):].lstrip()

def startstop_codeblock(outfile, delimiter=CODEBLOCK_DELIMITER, language="bash"):
    outfile.write(f"{delimiter}{language}\n")

def end_codeblock(outfile, delimiter=CODEBLOCK_DELIMITER):
    outfile.write(f"{delimiter}\n")

def write_line(outfile, line):
    outfile.write(line)

def toggle_state(state):
    return not state
