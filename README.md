# Emacs Copilot

Code generation library written in Emacs Lisp. The project aims to be an equivalent to other AI pair programmers, running Small Language Models on the user's computer.  
Code generation happens based on POST requests to a HTTP server and is inserted in place using Emacs Lisp native functions.  

## Dependencies

The project is a client library for accessing the [llama.cpp webserver](https://github.com/ggerganov/llama.cpp/blob/master/examples/server/README.md).  
It was specifically built for using the CodeGemma2b model, and expects the model's control structures.  
For instructions on how to access the llama.cpp HTTP server, refer to the docmentation above. Configure the server with the CodeGemma2b GGUF model, available [here](https://huggingface.co/google/codegemma-2b-GGUF).  

## Instalation

Clone the repository to your .emacs.d folder:

```shell
git clone https://github.com/mlemosf/emacs-copilot.git ~/.emacs.d/emacs-copilot

```

## Configuration

Change the endpoint in codegemma.el and point to where your llama.cpp HTTP server is:

```lisp
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

```lisp
(load-file ~/.emacs.d/emacs-copilot/codegemma.el)
```

To generate code, highlight code you want to use as prompt and run `M-x mlemosf/copilot`.

## Examples

### Generating models for a Django project:

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

### Generating simple algorithms

Prompt:
```python
def bubble_sort(arr: int):
	
```

Generated code:
```python
def bubble_sort(arr: int):
    
    n = len(arr)
    
    for i in range(n):
        for j in range(0, n-i-1):
            if arr[j] > arr[j+1]:
                arr[j], arr[j+1] = arr[j+1], arr[j]
            
    return arr

```

### Generating code based only on comments

Prompt:

```python
# Recursive Python function for finding the n element of the Fibonacci sequence

```

Generated code:
```python
# Recursive Python function for finding the n element of the Fibonacci sequence

def fib(n):
    if n < 1:
        return None
    elif n == 1:
        return 0
    elif n == 2:
        return 1
    else:
        return fib(n-1) + fib(n-2)
```




