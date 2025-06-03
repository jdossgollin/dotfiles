$pdf_mode = 1;
$pdflatex = 'pdflatex -shell-escape -synctex=1 -interaction=nonstopmode %O %S';
$xelatex = 'xelatex -shell-escape -synctex=1 -interaction=nonstopmode %O %S';
$lualatex = 'lualatex -shell-escape -synctex=1 -interaction=nonstopmode %O %S';

# Use SumatraPDF as PDF viewer on Windows, Skim on macOS
$pdf_previewer = 'open -a Skim';

# Clean up extra files
$clean_ext = 'bbl run.xml synctex.gz acn acr alg glg glo gls ist nav snm';

add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');

sub run_makeglossaries {
  if ( $silent ) {
    system "makeglossaries -q '$_[0]'";
  }
  else {
    system "makeglossaries '$_[0]'";
  };
}
