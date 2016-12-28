package cbrotli

import (
	"io"

	"gopkg.in/kothar/brotli-go.v0/dec"

	"github.com/itchio/wharf/pwr"
)

type brotliDecompressor struct{}

func (bc *brotliDecompressor) Apply(reader io.Reader) (io.Reader, error) {
	br := dec.NewBrotliReader(reader)
	return br, nil
}

func init() {
	pwr.RegisterDecompressor(pwr.CompressionAlgorithm_BROTLI, &brotliDecompressor{})
}
