;; Funcoes para usar code completion com o codegemma

(defun mlemosf/insert-control-structures (prompt)
  "Insere as estruturas especiais do CodeGemma"
  (let (
		(preffix "<|fim_preffix|>")
		(suffix "<|fim_suffix|>")
		(middle "<|fim_middle|>")
		)
	(format "%s%s%s%s" preffix prompt suffix middle)))

(defun mlemosf/gemma-remove-control-structures (response)
  "Remove estruturas de controle após geração"
  (let (
		(regex "\\(\<|f\\(im\\|ile\\)_\\(preffix\\|suffix\\|middle\\|separator\\)|>\\)")
		)
	(car (split-string response regex))))

(defun mlemosf/gemma-call-api (endpoint prompt)
  ;; Funcao para chamar a API do codegemma
  (let (
		(request-func
		 (request endpoint
		   :type "POST"
		   :sync t
		   :data (json-encode `(
								("prompt" . ,prompt)
								("n_predict" . 1024)
								("temperature" . 0.8)
								))
		   :parser 'json-read
		   :complete (cl-function
					  (lambda (&key data &allow-other-keys)
						(print data))))))
	(cdr
	 (assoc 'content (request-response-data request-func)))))


;; Funcoes para usar code completion com o codegemma
(defun mlemosf/copilot ()
  "Insere o texto gerado no lugar"
  (interactive)
  (let (
		(endpoint "http://192.168.0.5:8080/completion")
		)
	(insert
	 (mlemosf/gemma-remove-control-structures
	  (mlemosf/gemma-call-api
	   endpoint
	   (mlemosf/insert-control-structures
		(buffer-substring (region-beginning) (region-end))))))))
