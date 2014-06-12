/**
 * Translation Magento Varien_Object to Zephir
 * @author: Sergey Petrov <sergoslav@gmail.com>
 */

namespace Varien;

class Vobject
{
    /**
     * Retrieves data from the object
     *
     * If key__v is empty will return all the data as an array
     * Otherwise it will return value of the attribute specified by key__v
     *
     * If index__v is specified it will assume that attribute data is an array
     * and retrieve corresponding member.
     *
     * @param string key__v
     * @param string|int index__v
     * @return mixed
     */
    public function getData(string key__v = "", var index__v = null, var this_data__v)
    {
        if (key__v === "") {
            return this_data__v;
        }

        var default__v = null;

        // accept a/b/c as ['a']['b']['c']
        if (strpos(key__v,"/"))
        {

            var keyArr__v;
            let keyArr__v = explode("/", key__v);
            var data__v;
            let data__v = this_data__v;
            var k__v;
            for k__v in keyArr__v
            {
                if (k__v === "") {
                    return default__v;
                }
                if (is_array(data__v)) {
                    if (!isset(data__v[k__v])) {
                        return default__v;
                    }
                    let data__v = data__v[k__v];
                } else {
                    if (get_class(data__v) == "Varien_Object") {


                        let data__v = data__v->getData(k__v, null, this_data__v);
                    } else {
                        return default__v;
                    }
                }
            }
            return data__v;
        }

        // legacy functionality for index__v

        if (isset(this_data__v[key__v]))
        {
            if (is_null(index__v)) {
                return this_data__v[key__v];
            }

            var value__v;
            let value__v = this_data__v[key__v];
            if (is_array(value__v)) {
                /**
                 * If we have any data, even if it empty - we should use it, anyway
                 */
                if (isset(value__v[index__v])) {
                    return value__v[index__v];
                }
                return null;
            } else {
                if (is_string(value__v)) {
                            var arr__v;
                            let arr__v = explode("\n", value__v);
                            return (isset(arr__v[index__v]) && (!empty(arr__v[index__v]) || strlen(arr__v[index__v]) > 0))
                                ? arr__v[index__v] : null;
                } else {
                    if (get_class(value__v) == "Varien_Object") {
                        return value__v->getData(index__v, null, this_data__v);
                    }
                }
            }
            return default__v;
        }
        return default__v;
    }
}