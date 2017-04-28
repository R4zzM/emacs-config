;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Switch to / Toggle various buffers;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun try-toggle-buffer-in-current-window (name)
  "If buffer is visible in current window, show previous buffer."
  "Else, if buffer is open, show it in current window."
  "Else do nothing and return nil."
  (cond ((string= name (buffer-name (window-buffer)))
         (previous-buffer))
        ((get-buffer name)
         (switch-to-buffer name))
        (t
         nil)))

(defun raz-toggle-init-file-in-current-window ()
  (interactive)
  (unless (try-toggle-buffer-in-current-window (file-name-nondirectory user-init-file))
    (find-file (file-truename user-init-file))))

(defun raz-toggle-eshell-in-current-window ()
  (interactive)
  (unless (try-toggle-buffer-in-current-window "*eshell*")
    (eshell)))

;; Omni comment function from
;; http://stackoverflow.com/questions/9688748/emacs-comment-uncomment-current-line
(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))

(defun raz-buffer-menu-with-prefix-arg ()
  "Calls buffer-menu with prefix argument to hide all buffers not visiting files."
  (interactive)
  (setq current-prefix-arg '(4))
  (call-interactively 'buffer-menu))

(defun raz-buffer-menu-with-prefix-arg-other-window ()
  "Calls buffer-menu with prefix argument to hide all buffers not visiting files."
  (interactive)
  (setq current-prefix-arg '(4))
  (call-interactively 'buffer-menu-other-window))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Text from minibuffer functions;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmacro raz-insert-line (text)
  `(progn (insert ,text)
          (newline)))

(defun raz-concat-with-self (string times)
  (let ((result ""))
    (dotimes (i times result)
      (setq result (concat result string)))))

(defun raz-skeleton-section (text)
  (interactive "sText: ")
  (let* ((middle-row (concat comment-start text comment-start))
         (middle-row-len (string-width middle-row))
         (upper-and-lower-row (raz-concat-with-self
                               (substring comment-start 0 1)
                               middle-row-len)))
    (raz-insert-line upper-and-lower-row)
    (raz-insert-line middle-row)
    (raz-insert-line upper-and-lower-row)))

;; Inserts a boilerplate program into a file.
;; Is there any way for emacs to add an indent instead of manually adding spaces?
(defun raz-skeleton-cpp-main ()
  (interactive)
  (let* ((includes "#include <iostream>")
         (main "int main()")
         (opening-brace "{")
         (closing-brace "}")
         (return-statement "    return 0;"))
    (progn (insert includes)
           (newline)
           (newline)
           (insert main)
           (newline)
           (insert opening-brace)
           (newline)
           (newline)
           (insert return-statement)
           (newline)
           (insert closing-brace))))

(defun raz-skeleton-cpp-class (name)
  (interactive "sClass name: ")
  (let ((signature (concat "class " name))
        (opening-bracket "{")
        (public "public:")
        (ctor (concat "    " name "() {}"))
        (dtor (concat "    ~" name "() = default;"))
        (private "private:")
        (closing-bracket "};"))
    (progn (insert signature)
           (newline)
           (insert opening-bracket)
           (newline)
           (insert public)
           (newline)
           (insert ctor)
           (newline)
           (insert dtor)
           (newline)
           (newline)
           (insert private)
           (newline)
           (newline)
           (insert closing-bracket)
           (newline))))

(defun raz-ack-in-project-root ()
  (interactive)
  (setq current-prefix-arg '(4)) ; C-u
  (call-interactively 'ack))

;; TODO
(defun raz-ack-in-custom-root ()
  (interactive)
  (setq current-prefix-arg '(16)) ; C-u
  (call-interactively 'ack))
