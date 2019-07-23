/* program_my_extract.do */
/* Lars Vilhuber */
/* Originally created 2018-02-16 */
/* Extracts data from GPH files and saves them in the data directory */

capture program drop my_extract
program define my_extract
   local fullpath "`1'"
   di "Processing `fullpath'"
   * find the first of max 2 slashes
   local start=strpos("`fullpath'","/")
   * find the second position
   local partpath=substr("`fullpath'",`start'+1,length("`fullpath'")-`start'+1)
   local filestart=strpos("`partpath'","/")
   * di "find the position of .gph "
   local filename=substr("`fullpath'",`start' +`filestart'+1,length("`fullpath'")-`start'-`filestart'+1)
   di "filename = `filename'"
   local gphstart=strpos("`filename'",".gph")
   local basename=substr("`filename'",1,`gphstart'-1)
   di "   Filename base is `basename'"

   * now we can start processing
   qui graph use `fullpath'
   serset use
   saveold $data/`basename', replace version(12)
   export delimited using "$data/`basename'.csv", delimiter(";") replace
end
