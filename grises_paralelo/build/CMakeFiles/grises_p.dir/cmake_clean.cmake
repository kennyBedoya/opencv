file(REMOVE_RECURSE
  "grises_p.pdb"
  "grises_p"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/grises_p.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
