package main

type RandomizedSet struct {
    Map map[int]int
    sl []int
}


func Constructor() RandomizedSet {
    return RandomizedSet{
        Map: make(map[int]int),
        sl: make([]int, 0),
    }
}


func (this *RandomizedSet) Insert(val int) bool {
    if _, ok := this.Map[val]; !ok {
        this.Map[val] = val
        return true
    }
    return false
}


func (this *RandomizedSet) Remove(val int) bool {
    if _, ok := this.Map[val]; ok {
        delete(this.Map, val)
        return true
    }
    return false
}


func (this *RandomizedSet) GetRandom() int {
    this.sl = make([]int,0)
    for _, v := range this.Map {
        this.sl = append(this.sl, v)
    }

	randomIndex := rand.Intn(len(this.sl))

	return this.sl[randomIndex]
}


