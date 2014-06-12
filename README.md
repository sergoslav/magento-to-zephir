magento-to-zephir
=================

Translate Magento to Zephir

varien.so - сompiled php extension.

### Include in Magento:

In class Varien_Object :

```````php
public function getData($key='', $index=null)
{
        $varient = new Varien\Vobject();
        return $varient->getData($key, $index, $this->_data);
}
```````
