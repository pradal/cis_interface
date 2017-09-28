import os
import nose.tools as nt
import tempfile
from cis_interface.examples.tests import TestExample


class TestExampleHelloPar(TestExample):
    r"""Test the parallel Hello example."""

    def __init__(self, *args, **kwargs):
        super(TestExampleHelloPar, self).__init__(*args, **kwargs)
        self.name = 'helloPar'

    @property
    def input_file(self):
        r"""Input file."""
        return os.path.join(self.yamldir, 'Input', 'input.txt')
    
    @property
    def output_file(self):
        r"""Output file."""
        return os.path.join(tempfile.gettempdir(), 'output_helloPar.txt')
    
    def check_result(self):
        r"""Assert that contents of input/output files are identical."""
        assert(os.path.isfile(self.input_file))
        assert(os.path.isfile(self.output_file))
        with open(self.input_file, 'r') as fd:
            icont = fd.read()
        with open(self.output_file, 'r') as fd:
            ocont = fd.read()
        nt.assert_equal(icont, ocont)
