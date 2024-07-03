# Emacs Copilot

Code generation library written in Emacs Lisp.

## Dependencies

The project is a client library for accessing the [llama.cpp webserver](https://github.com/ggerganov/llama.cpp/blob/master/examples/server/README.md).  
It was specifically built for using the CodeGemma 2b model, and expects the model's control structures.

## Instalation

Clone the repository to your .emacs.d folder

```shell
git clone https://github.com/mlemosf/emacs-copilot.git ~/.emacs.d/emacs-copilot

```

## Configuration

Change the endpoint in codegemma.el and point to where your llama.cpp HTTP server is

```
(defun mlemosf/copilot ()
  "Insere o texto gerado no lugar"
  (interactive)
  (let (
		(endpoint "<endpoint>")
		)
	(insert
	 (mlemosf/gemma-remove-control-structures
	  (mlemosf/gemma-call-api
	   endpoint
	   (mlemosf/insert-control-structures
		(buffer-substring (region-beginning) (region-end))))))))

```

## Running

Load the file with `load-file`.

```
(load-file ~/.emacs.d/emacs-copilot/codegemma.el)
```

To generate code, highlight code you want to use as prompt and run M-x `mlemosf/copilot`.

## Examples

Generating models for a Django project:

Prompt:

```python
# Generate a model Author with 'name' and 'num_published' attributes and __str__ method
class Author(models.Model):
```

Generated code:

```python
# Generate a model Author with 'name' and 'num_published' attributes and __str__ method
class Author(models.Model):
    
    name = models.CharField(max_length=250)
    num_published = models.IntegerField()

    def __str__(self):
        return f'{self.name} ({self.num_published})'
```
