
(defun make-cd (title artist rating ripped)
  (list :title title :artist artist :rating rating :ripped ripped))
(make-cd "Roses" "Kathy Mattea" 7 t)

(setq *db* nil)

(defun add-record (cd)
  (push cd *db*))

(defun dump-db ()
  (dolist (cd *db*)
    (princ (format "TITLE: %s\n" (plist-get cd :title)))
    (princ (format "ARTIST: %s\n" (plist-get cd :artist)))
    (princ (format "RATING: %s\n" (plist-get cd :rating)))
    (princ (format "RIPPED: %s\n" (plist-get cd :ripped)))
    (princ "\n")))

(defun prompt-read (prompt)
  (princ (read-string (format "%s: " prompt ))))

(defun prompt-for-cd ()
  (make-cd
   (prompt-read "Title")
   (prompt-read "Artist")
   (string-to-number (prompt-read "Rating"))
   (y-or-n-p "Ripped [y/n]"))) 

(defun add-cds ()
  (while 
      (progn
        (add-record (prompt-for-cd) )
        (y-or-n-p "Another? [y/n]: ")
        )))
(defun save-db (filename data)
  (with-temp-file filename
    (prin1 data (current-buffer))))

(defun load-db (filename)
  (with-temp-file filename
    (insert-file-contents filename)
    (cl-assert (eq (point)(point-min)))
    (setq *db* (read (current-buffer)))))
