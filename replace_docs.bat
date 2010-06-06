svn rm docs 
svn ci -m "deleting old docs" docs
ren doc_tmp docs
svn add docs
svn ci -m "adding new docs" docs